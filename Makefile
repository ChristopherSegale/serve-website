BIN=serve-website
LISP=sbcl
BUNDLE=bundle
LISPFLAGS=--no-sysinit --non-interactive
LIBS=:hunchentoot :cl-who :bordeaux-threads
LOLIBS=--eval '(asdf:load-system :hunchentoot)' \
       --eval '(asdf:load-system :cl-who)' \
       --eval '(asdf:load-system :bordeaux-threads)'
BNFLAGS=--eval "(ql:quickload '($(LIBS)))" \
        --eval "(ql:bundle-systems '($(LIBS)) :to \"$(BUNDLE)/\")" \
        --eval '(exit)'
BUILDFLAGS=--load $(BUNDLE)/bundle.lisp \
           $(LOLIBS) \
           --eval '(load "serve-website.asd")' \
           --eval '(asdf:make :serve-website)'
CACHE=~/.cache/common-lisp/sbcl-$(shell sbcl --version | cut -d ' ' -f 2)-linux-x64$(shell pwd)
RM=rm -rf

all: $(BIN)

$(BIN): $(BUNDLE)
	$(LISP) $(LISPFLAGS) $(BUILDFLAGS)

$(BUNDLE):
	$(LISP) $(LISPFLAGS) $(BNFLAGS)

clean:
	$(RM) $(CACHE)/*.fasl
	$(RM) $(BIN)
