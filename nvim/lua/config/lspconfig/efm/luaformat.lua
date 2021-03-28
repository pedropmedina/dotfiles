return {
    formatCommand = ([[
        lua-format -i
        --no-keep-simple-function-one-line
        --column-limit=120
        --single-quote-to-double-quote
        --spaces-around-equals-in-field
        --spaces-inside-table-braces
        --break-before-functioncall-rp
        --break-after-functioncall-lp
        --chop-down-table
    ]]):gsub("\n", ""),
    formatStdin = true
}

