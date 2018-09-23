# Lanyon for blogc

[Lanyon](http://lanyon.getpoole.com/) is an unassuming [Jekyll](http://jekyllrb.com) theme that places content first by tucking away navigation in a hidden drawer. It's based on [Poole](http://getpoole.com), the Jekyll butler.

This is the exact same theme ported to [blogc](http://blogc.org).

![Lanyon](https://f.cloud.github.com/assets/98681/1825266/be03f014-71b0-11e3-9539-876e61530e24.png)
![Lanyon with open sidebar](https://f.cloud.github.com/assets/98681/1825267/be04a914-71b0-11e3-966f-8afe9894c729.png)


## Contents

- [Usage](#usage)
- [Options](#options)
  - [Sidebar menu](#sidebar-menu)
  - [Themes](#themes)
  - [Reverse layout](#reverse-layout)
- [Author](#author)
- [License](#license)


## Usage

Lanyon for blogc is ready to use, just run `blogc-make` in your terminal and you are good to go.


## Options

Lanyon includes some customizable options, typically applied via classes on the `<body>` element.


### Sidebar menu

At this time pages and links can be added to the sidebar by editing `templates/main.tmpl` and `Makefile`.

Relevant `templates/main.tmpl` parts:

```html
<!-- Home link -->
<a class="sidebar-nav-item{%if MAKE_RULE == "index" %} active{% endif %}" href="{{ BASE_URL }}/">Home</a>
<!-- About link -->
<a class="sidebar-nav-item{%if MAKE_SLUG == "about" %} active{% endif %}" href="{{ BASE_URL }}/about/">About</a>

<a class="sidebar-nav-item" href="https://github.com/shiba89/lanyon-blogc/archive/master.zip">Download</a>
<a class="sidebar-nav-item" href="https://github.com/shiba89/lanyon-blogc">GitHub project</a>
<span class="sidebar-nav-item">Currently devel</span>
```

Relevant `Makefile` parts:

```desktop
[pages]
about
404
```

This will hopefully change in the future.


### Themes

Lanyon ships with eight optional themes based on the [base16 color scheme](https://github.com/chriskempson/base16). Apply a theme to change the color scheme (mostly applies to sidebar and links).

![Lanyon with red theme](https://f.cloud.github.com/assets/98681/1825270/be065110-71b0-11e3-9ed8-9b8de753a4af.png)
![Lanyon with red theme and open sidebar](https://f.cloud.github.com/assets/98681/1825269/be05ec20-71b0-11e3-91ea-a9138ef07186.png)

There are eight themes available at this time.

![Available theme classes](https://f.cloud.github.com/assets/98681/1817044/e5b0ec06-6f68-11e3-83d7-acd1942797a1.png)

To use a theme, add any one of the available theme classes to the `<body>` element in the `templates/main.tmpl` template, like so:

```html
<body class="theme-base-08">
  ...
</body>
```

To create your own theme, look to the Themes section of [included CSS file](https://github.com/shiba89/lanyon-blogc/blob/master/public/css/lanyon.css). Copy any existing theme (they're only a few lines of CSS), rename it, and change the provided colors.


### Reverse layout

![Lanyon with reverse layout](https://f.cloud.github.com/assets/98681/1825265/be03f2e4-71b0-11e3-89f1-360705524495.png)
![Lanyon with reverse layout and open sidebar](https://f.cloud.github.com/assets/98681/1825268/be056174-71b0-11e3-88c8-5055bca4307f.png)

Reverse the page orientation with a single class.

```html
<body class="layout-reverse">
  ...
</body>
```


### Sidebar overlay instead of push

Make the sidebar overlap the viewport content with a single class:

```html
<body class="sidebar-overlay">
  ...
</body>
```

This will keep the content stationary and slide in the sidebar over the side content. It also adds a `box-shadow` based outline to the toggle for contrast against backgrounds, as well as a `box-shadow` on the sidebar for depth.

It's also available for a reversed layout when you add both classes:

```html
<body class="layout-reverse sidebar-overlay">
  ...
</body>
```


### Sidebar open on page load

Show an open sidebar on page load by modifying the `<input>` to add the `checked` boolean attribute:

```html
<input type="checkbox" class="sidebar-checkbox" id="sidebar-checkbox" checked>
```

You can also conditionally show the sidebar open on a per-page basis. For example, here's how you could have it open on the About page only:

```html
<input type="checkbox" class="sidebar-checkbox" id="sidebar-checkbox"{% if MAKE_SLUG == "about" %} checked{% endif %}>
```


## Author

**Shiba**

**Mark Otto**
- <https://github.com/mdo>
- <https://twitter.com/mdo>


## License

Lanyon for blogc is open sourced under the [GPL & MIT license](LICENSE.md).

<3
