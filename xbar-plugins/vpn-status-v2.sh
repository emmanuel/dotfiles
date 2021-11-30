#!/bin/bash
# <xbar.title>VPN Status</xbar.title>
# <xbar.version>v1.2</xbar.version>
# <xbar.author>Emmanuel Gomez</xbar.author>
# <xbar.author.github>emmanuel</xbar.author.github>
# <xbar.desc>Connect/Disconnect OpenConnect + show status</xbar.desc>
# <xbar.image></xbar.image>

# Credit for original concept and initial work to: Jesse Jarzynka
# Credit for maintenance and extension to: Ventz Petkov

# Updated by: Emmanuel Gomez (2021-07-09)
#   * Updated for use as an xbar plugin (replaced `bitbar.*` with `xbar.*`)
#   * 

# Updated by: Ventz Petkov (8-31-18)
#   * merged feature for token/pin input (ex: Duo/Yubikey/Google Authenticator) contributed by Harry Hoffman <hhoffman@ip-solutions.net>
#   * added option to pick "push/sms/phone" (ex: Duo) vs token/pin (Yubikey/Google Authenticator/Duo)

# Updated by: Ventz Petkov (11-15-17)
#   * cleared up documentation
#   * incremented 'VPN_INTERFACE' to 'utun99' to avoid collisions with other VPNs

# Updated by: Ventz Petkov (9-28-17)
#   * fixed for Mac OS X High Sierra (10.13)

# Updated by: Ventz Petkov (7-24-17)
#   * fixed openconnect (did not work with new 2nd password prompt)
#   * added ability to work with "Duo" 2-factor auth
#   * changed icons

#########################################################
# USER CHANGES #
#########################################################

# 1.) Updated your sudo config with (edit "osx-username" with your username):
#osx-username ALL=(ALL) NOPASSWD: /usr/local/bin/openconnect
#osx-username ALL=(ALL) NOPASSWD: /usr/bin/killall -2 openconnect


# 2.) Make sure openconnect binary is located here:
#     (If you don't have it installed: "brew install openconnect")
# VPN_EXECUTABLE=/usr/local/bin/openconnect
# Homebrew installs to `/usr/local` on Intel, and `/opt/homebrew` on Apple Silicon
VPN_EXECUTABLE=/opt/homebrew/bin/openconnect
VPN_PID_PATH="$HOME/.openconnect.pid"

# NOTES:
# * https://github.com/openconnect/openconnect-gui/issues/230#issuecomment-381093573
# * http://git.infradead.org/users/dwmw2/vpnc-scripts.git/history/HEAD:/vpnc-script

# SCRIPT_DIR=$(cd `dirname $0`; pwd -P)
# SCRIPT_DIR=$(cd `dirname $BASH_SOURCE[0]`; pwd -P)
# SCRIPT_DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"

# source "${SCRIPT_DIR}/openconnect-support/vpn_settings.env"

# VPNC_SCRIPT_PATH="${VPNC_SCRIPT_PATH:-/usr/local/etc/vpnc-script}"

# 3.) Update your AnyConnect VPN host
# VPN_HOST="vpn.domain.tld"
# VPN_HOST="${VPN_HOST?:must be set}"
VPN_HOST="general.vpn.t-mobile.com"

# VPN_CONNECTION_LABEL="${VPN_CONNECTION_LABEL?:must be set}"
VPN_CONNECTION_LABEL="T-Mobile"

# 4.) Update your AnyConnect username + tunnel
# VPN_USERNAME="vpn_username@domain.tld#VPN_TUNNEL_OPTIONALLY"
[[ -n "$TRACE" ]] && set -x
GET_VPN_USERNAME="security find-internet-password -l $VPN_HOST | grep acct | cut -d= -f2 | cut -d'\"' -f2"
# VPN_USERNAME="${VPN_USERNAME?:must be set}"
VPN_USERNAME="$(eval $GET_VPN_USERNAME)"

# VPN_GROUP="${VPN_GROUP?:must be set}"

# 5.) Push 2FA (ex: Duo), or Pin/Token (ex: Yubikey, Google Authenticator, TOTP)
# MFA_TYPE="${MFA_TYPE?:must be set}"
# MFA_TYPE="Okta"
# MFA_TYPE="push"
#MFA_TYPE="Yubikey"
# ---
# * For Push (and other Duo specifics), options include:
# "push", "sms", or "phone"
# ---
# * For Yubikey/Google Authenticator/other TOTP, specify any name for prompt:
# "any-name-of-product-to-be-prompted-about"
# MFA_TYPE="Yubikey" | MFA_TYPE="Google Authenticator" | MFA_TYPE="Duo"
# (essentially, anything _other_ than the "push", "sms", or "phone" options)
# ---

# 6.) Create an encrypted password entry in your OS X Keychain:
#      a.) Open "Keychain Access" and 
#      b.) Click on "login" keychain (top left corner)
#      c.) Click on "Passwords" category (bottom left corner)
#      d.) From the "File" menu, select -> "New Password Item..."
#      e.) For "Keychain Item Name" and "Account Name" use the value for "VPN_HOST" and "VPN_USERNAME" respectively
#      f.) For "Password" enter your VPN AnyConnect password.

# This will retrieve that password securely at run time when you connect, and feed it to openconnect
# No storing passwords unenin plain text files! :)
GET_VPN_PASSWORD="security find-internet-password -wl $VPN_HOST"

VPN_TIMEOUT=10

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# END-OF-USER-SETTINGS #
#########################################################

VPN_INTERFACE="utun99"

# Command to determine if VPN is connected or disconnected
VPN_CONNECTED="/sbin/ifconfig | grep -A3 $VPN_INTERFACE | grep inet"
# Command to run to disconnect VPN
VPN_DISCONNECT_CMD="/usr/bin/killall -2 openconnect"

# GUI Prompt for your token/key (ex: Duo/Yubikey/Google Authenticator)
function prompt_2fa_method() {
  if [ "$1" == "push" ]; then
    echo "push"
  elif [ "$1" == "sms" ]; then
    echo "sms"
  elif [ "$1" == "phone" ]; then
    echo "phone"
  else
    osascript <<EOF
    tell app "System Events"
      text returned of (display dialog "Enter $1 token:" default answer "" buttons {"OK"} default button 1 with title "$(basename $0)")
    end tell
EOF
  fi
}


case "$1" in
  connect)
    # VPN_PASSWORD="$(eval "$GET_VPN_PASSWORD")"
    # MFA_VALUE="$(prompt_2fa_method "${MFA_TYPE}")"
    # VPN connection command, should eventually result in $VPN_CONNECTED,
    # may need to be modified for VPN clients other than openconnect

    # Connect based on your 2FA selection (see: $MFA_TYPE for options)
    # For anything else (non-duo) - you would provide your token (see: stoken)
    # echo -e "$VPN_PASSWORD\n$MFA_VALUE\n" |
    # echo -e "${VPN_PASSWORD}" | \

    bash -c "$GET_VPN_PASSWORD" | \
      sudo "${VPN_EXECUTABLE}" \
        --pid-file="${VPN_PID_PATH}" \
        --interface="${VPN_INTERFACE}" \
        --useragent="AnyConnect Darwin_x64 3.9.04053" \
        --user="${VPN_USERNAME}" \
        --passwd-on-stdin \
        --background \
          "${VPN_HOST}"
     # &> /dev/null

    # while [ -ne "$VPN_TIMEOUT" 0 ]; do
    #   if eval "$VPN_CONNECTED"; do break; done
    #   sleep 1
    #   # VPN_TIMEOUT=$()
    # done

    # Wait for connection so menu item refreshes instantly
    until eval "$VPN_CONNECTED"; do sleep 1; done
    osascript -e "display notification \"Connected\" with title \"${VPN_CONNECTION_LABEL}\""
    ;;
  disconnect)
    sudo /usr/bin/killall -INT openconnect
    # sudo /usr/bin/killall -2 openconnect
    # Wait for disconnection so menu item refreshes instantly
    until [ -z "$(eval "$VPN_CONNECTED")" ]; do sleep 1; done
    osascript -e "display notification \"Disconnected\" with title \"${VPN_CONNECTION_LABEL}\""
    ;;
esac


if [ -n "$(eval "$VPN_CONNECTED")" ]; then
  # echo "${VPN_CONNECTION_LABEL} ✅"
  # echo "${VPN_CONNECTION_LABEL} ✓"
  echo "${VPN_CONNECTION_LABEL} 🔒"
  echo '---'
  echo "Disconnect ${VPN_CONNECTION_LABEL} | bash='$0' param1=disconnect terminal=false refresh=true"
  exit
else
  echo "${VPN_CONNECTION_LABEL} ❌"
  # Alternative icon -> but not visible enough (too small)
  # echo "${VPN_CONNECTION_LABEL} 𝗑"
  # Alternative icon -> but not distinct enough (too similar to "connected")
  # echo "${VPN_CONNECTION_LABEL} 🔓"
  echo '---'
  echo "Connect ${VPN_CONNECTION_LABEL} | bash='$0' param1=connect terminal=false refresh=true"
  # For debugging!
  #echo "Connect ${VPN_CONNECTION_LABEL} | bash='$0' param1=connect terminal=true refresh=true"
  exit
fi
