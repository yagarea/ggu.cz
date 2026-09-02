---
name: "Blades"
repository: https://github.com/grego/blades
website: https://getblades.org
description: "Blazing fast dead simple static site generator."
author: Maroš Grego
license: GPLv3
category: Software
---

Blades is made to do one job and do it well - generate HTML files from the provided
content using the provided templates.  
Thanks to [zero-copy](https://serde.rs/lifetimes.html#borrowing-data-in-a-derived-impl) deserialization
and the [Ramhorns](https://github.com/maciejhirsz/ramhorns) templating engine,
it renders the whole site in milliseconds, possibly more than
[20 times](https://github.com/grego/ssg-bench) faster than other generators like Hugo.
