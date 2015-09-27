# Content

AUTHOR_NAME = "Shiba"
AUTHOR_EMAIL = "example@email.com"
SITE_TITLE = "Lanyon"
SITE_TAGLINE = "Now for blogc too!"
SITE_DESCRIPTION = "A reserved <a href="http://jekyllrb.com" target="_blank">Jekyll</a> theme that places the utmost gravity on content with a hidden drawer. Made by <a href="https://twitter.com/mdo" target="_blank">@mdo</a>.<br>Ported to <a href="http://blogc.org/">blogc</a> by Shiba."
LOCALE = "en_US.utf-8"

POSTS_PER_PAGE = 5
POSTS_PER_PAGE_ATOM = 10

POSTS = \
	2014-01-02-introducing-lanyon \
	2014-01-01-example-content \
	2013-12-31-whats-jekyll \
	$(NULL)

PAGES = \
	about \
	404 \
	$(NULL)

ASSETS = \
	assets/css/poole.css \
	assets/css/syntax.css \
	assets/css/lanyon.css \
	assets/apple-touch-icon-precomposed.png \
	assets/favicon.ico \
	$(NULL)


# Arguments

BLOGC ?= $(shell which blogc)
MKDIR ?= $(shell which mkdir)
CP ?= $(shell which cp)
OUTPUT_DIR ?= _build
BASE_DOMAIN ?= http://example.com
BASE_URL ?=

DATE_FORMAT= "%d %b %Y"
DATE_FORMAT_ATOM = "%Y-%m-%dT%H:%M:%SZ"

BLOGC_COMMAND = \
	LC_ALL=$(LOCALE) \
	$(BLOGC) \
		-D AUTHOR_NAME=$(AUTHOR_NAME) \
		-D SITE_TITLE=$(SITE_TITLE) \
		-D SITE_TAGLINE=$(SITE_TAGLINE) \
		-D SITE_DESCRIPTION=$(SITE_DESCRIPTION) \
		-D BASE_DOMAIN=$(BASE_DOMAIN) \
		-D BASE_URL=$(BASE_URL) \
	$(NULL)


# Rules

LAST_PAGE = $(shell $(BLOGC_COMMAND) \
	-D FILTER_PAGE=1 \
	-D FILTER_PER_PAGE=$(POSTS_PER_PAGE) \
	-p LAST_PAGE \
	-l \
	$(addprefix content/post/, $(addsuffix .md, $(POSTS))))

all: \
	$(OUTPUT_DIR)/index.html \
	$(OUTPUT_DIR)/atom.xml \
	$(addprefix $(OUTPUT_DIR)/, $(ASSETS)) \
	$(addprefix $(OUTPUT_DIR)/post/, $(addsuffix /index.html, $(POSTS))) \
	$(addprefix $(OUTPUT_DIR)/, $(addsuffix /index.html, $(PAGES))) \
	$(addprefix $(OUTPUT_DIR)/page/, $(addsuffix /index.html, \
		$(shell for i in $(shell seq 1 $(LAST_PAGE)); do echo $$i; done)))

$(OUTPUT_DIR)/index.html: $(addprefix content/post/, $(addsuffix .md, $(POSTS))) templates/main.tmpl Makefile
	$(BLOGC_COMMAND) \
		-D DATE_FORMAT=$(DATE_FORMAT) \
		-D FILTER_PAGE=1 \
		-D FILTER_PER_PAGE=$(POSTS_PER_PAGE) \
		-D MENU=blog \
		-l \
		-o $@ \
		-t templates/main.tmpl \
		$(addprefix content/post/, $(addsuffix .md, $(POSTS)))

$(OUTPUT_DIR)/page/%/index.html: $(addprefix content/post/, $(addsuffix .md, $(POSTS))) templates/main.tmpl Makefile
	$(BLOGC_COMMAND) \
		-D DATE_FORMAT=$(DATE_FORMAT) \
		-D FILTER_PAGE=$(shell echo $@ | sed -e 's,^$(OUTPUT_DIR)/page/,,' -e 's,/index\.html$$,,')\
		-D FILTER_PER_PAGE=$(POSTS_PER_PAGE) \
		-D MENU=blog \
		-l \
		-o $@ \
		-t templates/main.tmpl \
		$(addprefix content/post/, $(addsuffix .md, $(POSTS)))

$(OUTPUT_DIR)/atom.xml: $(addprefix content/post/, $(addsuffix .md, $(POSTS))) templates/atom.tmpl Makefile
	$(BLOGC_COMMAND) \
		-D DATE_FORMAT=$(DATE_FORMAT_ATOM) \
		-D FILTER_PAGE=1 \
		-D FILTER_PER_PAGE=$(POSTS_PER_PAGE_ATOM) \
		-l \
		-o $@ \
		-t templates/atom.tmpl \
		$(addprefix content/post/, $(addsuffix .md, $(POSTS)))

$(OUTPUT_DIR)/post/%/index.html: MENU = blog
$(OUTPUT_DIR)/post/%/index.html: IS_POST = 1

$(OUTPUT_DIR)/about/index.html: MENU = about

$(OUTPUT_DIR)/%/index.html: content/%.md templates/main.tmpl Makefile
	$(BLOGC_COMMAND) \
		-D DATE_FORMAT=$(DATE_FORMAT) \
		-D MENU=$(MENU) \
		$(shell test "$(IS_POST)" -eq 1 && echo -D IS_POST=1) \
		-o $@ \
		-t templates/main.tmpl \
		$<

$(OUTPUT_DIR)/assets/%: assets/% Makefile
	$(MKDIR) -p $(dir $@) && \
			$(CP) $< $@

clean:
	rm -rf "$(OUTPUT_DIR)/"

.PHONY: all clean
