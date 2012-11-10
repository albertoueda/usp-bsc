# vim: ft=make
.PHONY: monografia._graphics
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/generic/babel/babel.sty)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/base/article.cls)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/base/fontenc.sty)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/base/inputenc.sty)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/ltxmisc/url.sty)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/psnfss/times.sty)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/ucs/ucs.sty)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,atividades.tex)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,conceitos.tex)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,introducao.tex)
monografia.aux monografia.aux.make monografia.d monografia.pdf: $(call path-norm,monografia.tex)
.SECONDEXPANSION:
