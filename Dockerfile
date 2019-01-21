# Copyright (c) 2018-2019 Squary
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM frolvlad/alpine-glibc:alpine-3.8_glibc-2.28

LABEL maintainer="Squary"

ENV PATH /usr/local/texlive/2018/bin/x86_64-linux/:$PATH

RUN apk update && \
    apk add --no-cache bash gnupg perl wget xz && \
    apk add --no-cache --virtual=tl-unx tar fontconfig && \
    mkdir /tmp/install-tl-unx && \
    wget -qO - http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "collection-basic 1" \
      "collection-fontsrecommended 1" \
      "collection-langjapanese 1" \
      "collection-latex 1" \
      "collection-latexrecommended 1" \
      "collection-latexextra 1" \
      "tlpdbopt_install_docfiles 0" \
      "tlpdbopt_install_srcfiles 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      -force-platform x86_64-linux \
      -profile /tmp/install-tl-unx/texlive.profile && \
    tlmgr option repository ctan && \
    tlmgr install latexmk && \
    rm -rf /tmp/install-tl-unx && \
    apk del --purge tl-unx

RUN cd $(kpsewhich -var-value=TEXMFLOCAL) && \
    mkdir -p \
      fonts/opentype/google/notosanscjk \
      fonts/opentype/google/notoserifcjk && \
    wget -qP fonts/opentype/google/notosanscjk \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSansCJK-Regular.ttc \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSansCJK-Medium.ttc \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSansCJK-Bold.ttc \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSansCJK-Black.ttc && \
    wget -qP fonts/opentype/google/notoserifcjk \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSerifCJK-Light.ttc \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSerifCJK-Regular.ttc \
      https://github.com/googlei18n/noto-cjk/raw/master/NotoSerifCJK-Bold.ttc && \
    mktexlsr

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["bash"]
