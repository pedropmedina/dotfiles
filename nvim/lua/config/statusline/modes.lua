local modes = {}

function modes.mode_colors(COLORS, colors)
    local MODE_COLORS = {
        n = colors and colors.n or COLORS.extra_1,
        i = colors and colors.i or COLORS.success,
        c = colors and colors.c or COLORS.error,
        R = colors and colors.R or COLORS.warning,
        t = colors and colors.t or COLORS.extra_5,
        S = colors and colors.S or COLORS.success,
        s = colors and colors.s or COLORS.success,
        V = colors and colors.V or COLORS.info,
        v = colors and colors.v or COLORS.info,
        [''] = colors and colors['^V'] or COLORS.info
    }
    return MODE_COLORS
end

function modes.mode_texts(texts)
    local MODE_TEXTS = {
        n = texts and texts.n or ' • normal • ',
        i = texts and texts.i or ' • insert • ',
        c = texts and texts.c or ' • command • ',
        R = texts and texts.R or ' • replace • ',
        t = texts and texts.t or ' • terminal • ',
        S = texts and texts.S or ' • select • ',
        s = texts and texts.s or ' • select • ',
        V = texts and texts.V or ' • visual • ',
        v = texts and texts.v or ' • visual • ',
        [''] = texts and texts['^V'] or ' • visual •'
    }
    return MODE_TEXTS
end

return modes
