local modes = {}

function modes.mode_colors(defaults, colors)
    return {
        n = colors and colors.n or defaults.blue,
        i = colors and colors.i or defaults.green,
        c = colors and colors.c or defaults.red,
        R = colors and colors.R or defaults.yellow,
        t = colors and colors.t or defaults.gray,
        S = colors and colors.S or defaults.gray,
        s = colors and colors.s or defaults.gray,
        V = colors and colors.V or defaults.cyan,
        v = colors and colors.v or defaults.cyan,
        [''] = colors and colors['^V'] or defaults.cyan
    }
end

function modes.mode_texts(texts)
    return {
        n = texts and texts.n or ' normal ',
        i = texts and texts.i or ' insert ',
        c = texts and texts.c or ' command ',
        R = texts and texts.R or ' replace ',
        t = texts and texts.t or ' terminal ',
        S = texts and texts.S or ' select  ',
        s = texts and texts.s or ' select ',
        V = texts and texts.V or ' visual ',
        v = texts and texts.v or ' visual ',
        [''] = texts and texts['^V'] or ' visual '
    }
end

return modes
