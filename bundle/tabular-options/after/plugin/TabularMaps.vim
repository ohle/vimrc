" first = of the line
AddTabularPattern 1= /^[^=]*\zs=
" first space after first word of the line
AddTabularPattern 1s /^\s*[^ ][^ ]*\zs[ ]
" HTML tables
AddTabularPattern td /\(<td[^\/>]*>.\{-}<\/td>\)\|\(<th[^\/>]*>.\{-}<\/th>\)\|\(<td *\/>\)\|\(<th *\/>\)

  <tr> <th>Zustand</th> <th><code>.run</code></th> <th><code>.running</code></th> <th><code>.kill</code></th> </tr>
  <tr> <td>Wartet</td>  <td>vorhanden</td> <td/> <td/> <td/> </tr>
  <tr> <td>Läuft</td>   <td/> <td>vorhanden</td> <td/></tr>

  abcd
