#!/bin/bash

function proxyoff
{
    unset http_proxy HTTP_PROXY https_proxy HTTPS_PROXY no_proxy NO_PROXY
    # git config --global --unset http.proxy
    echo "Proxy disabled!"
    # echo -e "\033]50;SetProfile=ProxyOff\a"
}
# Proxy
function proxyon
{
    http_proxy=http://webproxysea.nordstrom.net:8181
    HTTP_PROXY=$http_proxy
    https_proxy=$http_proxy
    HTTPS_PROXY=$https_proxy
    no_proxy="127.0.0.1,localhost,.local,169.254/16,172.16/12,.nordstrom.net,.dev.nordstrom.com"
    # no_proxy="127.0.0.1,localhost,.local,169.254/16,10.0.0.0/8,172.16/12,192.168.0.0/16,.nordstrom.net,.dev.nordstrom.com"
    NO_PROXY=$no_proxy
    export http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY
    # git config --global http.proxy $http_proxy
    echo "Proxy enabled!"
    # echo -e "\033]50;SetProfile=Dark\a"
}

function proxyauto
{
    current_ssid=$(networksetup -getairportnetwork en0)
    requires_proxy=$(echo "${current_ssid}" | grep 'mobilenow')
    exit_code=$?
    if [[ "${exit_code}" == 0 ]]; then
        proxyon
    else
        proxyoff
    fi
}
