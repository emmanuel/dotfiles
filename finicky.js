module.exports = {
  defaultBrowser: "Browserosaurus",
  handlers: [{
      match: /^https?:\/\/meet\.google\.com\/.*$/,
      browser: "Google Chrome"
    },
    // https://github.com/johnste/finicky/wiki/Configuration-ideas#open-spotify-links-in-spotify-app
    {
      match: "open.spotify.com/*",
      browser: "Spotify"
    },
    // https://github.com/johnste/finicky/wiki/Configuration-ideas#open-zoom-links-in-zoom-app
    {
      match: [
        "zoom.us/*",
        finicky.matchDomains(/.*\zoom.us/),
        /zoom.us\/j\//,
      ],
      browser: "us.zoom.xos"
    },
    // {
    //   match: [
    //     "*.webex.com/*",
    //     // "*webex.com/*",
    //     // finicky.matchDomains(/.*\zoom.us/),
    //     // /zoom.us\/j\//,
    //   ],
    //   browser: "/Applications/Webex.app"
    // },
  ],
  // https://github.com/johnste/finicky/wiki/Configuration-ideas#remove-all-marketingtracking-information-from-urls
  rewrite: [{
    match: () => true, // Execute rewrite on all incoming urls to make this example easier to understand
    url({
      url
    }) {
      const removeKeysStartingWith = ["utm_", "uta_"]; // Remove all query parameters beginning with these strings
      const removeKeys = ["fblid", "gclid"]; // Remove all query parameters matching these keys

      const search = url.search
        .split("&")
        .map((parameter) => parameter.split("="))
        .filter(([key]) => !removeKeysStartingWith.some((startingWith) => key.startsWith(startingWith)))
        .filter(([key]) => !removeKeys.some((removeKey) => key === removeKey));

      return {
        ...url,
        search: search.map((parameter) => parameter.join("=")).join("&"),
      };
    },
  }],
}
