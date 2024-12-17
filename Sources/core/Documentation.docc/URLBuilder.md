# URLBuilder

``URLBuilder`` provides a builder model for piecewise creation of URLs.  Each
of the `URLBuilder` extensions returns a new `URLBuilder` (i.e., `URLComponents`)
with the appropriate changes made.

## Overview

Easily construct using a straight-forward builder model:

    let url = URLBuilder(string: "https://www.google.com")
        .append(path: "search")
        .append(query: "q", value: "maine")
        .url

Note that `URLComponents` is used under the hood and the preceding can also
be accomplished directly using a var `URLComponents` declaration.
