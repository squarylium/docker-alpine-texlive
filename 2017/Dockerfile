# Copyright (c) 2018 Squary
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM frolvlad/alpine-glibc:alpine-3.8_glibc-2.28

LABEL maintainer="Squary"

ENV PATH /usr/local/texlive/2017/bin/x86_64-linux/:$PATH

RUN apk update && \
    apk add --no-cache perl bash && \
    apk add --no-cache --virtual=tl-unx wget xz tar fontconfig && \
    mkdir /tmp/install-tl-unx && \
    wget -qO - ftp://tug.org/texlive/historic/2017/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "collection-basic 1" \
      "collection-fontsrecommended 1" \
      "collection-langjapanese 1" \
      "collection-latex 1" \
      "collection-latexrecommended 1" \
      "collection-latexextra 1" \
      "option_doc 0" \
      "option_src 0" \
      "selected_scheme scheme-basic" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      -repository ftp://tug.org/texlive/historic/2017/tlnet-final/ \
      -profile /tmp/install-tl-unx/texlive.profile && \
    tlmgr install \
      xetex.x86_64-linux \
      latexmk inconsolata siunitx physics \
      biber biblatex biblatex-phys logreq && \
    rm -rf /tmp/install-tl-unx && \
    apk del --purge tl-unx && \
    mkdir /workdir

RUN mkdir -p \
      "$(kpsewhich -var-value=TEXMFLOCAL)/fonts/opentype/google/notosanscjk" \
      "$(kpsewhich -var-value=TEXMFLOCAL)/fonts/opentype/google/notoserifcjk" && \
    wget -qP "$(kpsewhich -var-value=TEXMFLOCAL)/fonts/opentype/google/notosanscjk" \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSansCJK-Regular.ttc \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSansCJK-Medium.ttc \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSansCJK-Bold.ttc \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSansCJK-Black.ttc && \
    wget -qP "$(kpsewhich -var-value=TEXMFLOCAL)/fonts/opentype/google/notoserifcjk" \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSerifCJK-Light.ttc \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSerifCJK-Regular.ttc \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSerifCJK-Bold.ttc && \
    mktexlsr

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
