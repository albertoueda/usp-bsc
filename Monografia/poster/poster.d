# vim: ft=make
.PHONY: poster._graphics
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/generic/babel/babel.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/a0poster/a0size.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsfonts/amsfonts.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsfonts/amssymb.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsmath/amsbsy.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsmath/amsgen.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsmath/amsmath.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsmath/amsopn.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/amsmath/amstext.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/base/article.cls)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/base/ifthen.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/base/inputenc.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/color.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/epsfig.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/graphics.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/graphicx.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/keyval.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/graphics/trig.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/lettrine/lettrine.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/ltxmisc/boxedminipage.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/ltxmisc/shadow.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/psnfss/times.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/sciposter/sciposter.cls)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/tools/multicol.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf-texlive/tex/latex/ucs/ucs.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,/usr/share/texmf/tex/latex/lm/lmodern.sty)
poster.aux poster.aux.make poster.d poster.pdf: $(call path-norm,poster.tex)
.SECONDEXPANSION:
-include sp.png.gpi.d
poster.d: $$(call graphics-source,sp.png)
poster.pdf poster._graphics: $$(call graphics-target,sp.png)
-include aabb.png.gpi.d
poster.d: $$(call graphics-source,aabb.png)
poster.pdf poster._graphics: $$(call graphics-target,aabb.png)
-include sh.png.gpi.d
poster.d: $$(call graphics-source,sh.png)
poster.pdf poster._graphics: $$(call graphics-target,sh.png)
-include SAT.jpg.gpi.d
poster.d: $$(call graphics-source,SAT.jpg)
poster.pdf poster._graphics: $$(call graphics-target,SAT.jpg)
-include esqueleto.png.gpi.d
poster.d: $$(call graphics-source,esqueleto.png)
poster.pdf poster._graphics: $$(call graphics-target,esqueleto.png)
-include comImagem.png.gpi.d
poster.d: $$(call graphics-source,comImagem.png)
poster.pdf poster._graphics: $$(call graphics-target,comImagem.png)
-include lunarLandingE.png.gpi.d
poster.d: $$(call graphics-source,lunarLandingE.png)
poster.pdf poster._graphics: $$(call graphics-target,lunarLandingE.png)
-include lunarLanding.png.gpi.d
poster.d: $$(call graphics-source,lunarLanding.png)
poster.pdf poster._graphics: $$(call graphics-target,lunarLanding.png)
-include valleyE.png.gpi.d
poster.d: $$(call graphics-source,valleyE.png)
poster.pdf poster._graphics: $$(call graphics-target,valleyE.png)
-include valley.png.gpi.d
poster.d: $$(call graphics-source,valley.png)
poster.pdf poster._graphics: $$(call graphics-target,valley.png)
