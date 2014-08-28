" first = of the line
AddTabularPattern 1= /^[^=]*\zs=
" first : of the line
AddTabularPattern 1: /^[^:]*\zs:
" first space after first word of the line
AddTabularPattern 1s /^\s*[^ ][^ ]*\zs[ ]
" HTML tables
AddTabularPattern td /\(<td[^\/>]*>.\{-}<\/td>\)\|\(<th[^\/>]*>.\{-}<\/th>\)\|\(<td *\/>\)\|\(<th *\/>\)
