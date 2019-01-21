# squarylium/alpine-texlive

> TeX Live image based on Alpine Linux with glibc

## Alpine packages
- Packages for TeX Live Manager
    - gnupg, wget, xz

## TeX Live configuration
- basic scheme with following collections
    - basic, latex, latexrecommended, latexextra, fontsrecommended, langjapanese
- others
    - latexmk
    - Noto CJK fonts (for noto-otc option in pxchfon)
        - NotoSansCJK (Regular, Medium, Bold, Black)
        - NotoSerifCJK (Light, Regular, Bold)

## Usage

### Adding TeX Live packages
- `tlmgr install <package_names>`

## License

MIT License &copy; Squary
