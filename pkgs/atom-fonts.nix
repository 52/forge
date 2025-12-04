{
  iosevka,
}:
iosevka.override rec {
  set = "Atom";

  privateBuildPlan = ''
    [buildPlans.Iosevka${set}]
    family = "Iosevka ${set}"
    spacing = "term"
    serifs = "sans"

    [buildPlans.Iosevka${set}.variants.design]
    one = 'no-base'
    two = 'straight-neck-serifless'
    three = 'two-arcs'
    four = 'closed-serifless'
    five = 'upright-arched-serifless'
    six = 'straight-bar'
    seven = 'straight-serifless'
    eight = 'two-circles'
    nine = 'straight-bar'
    zero = 'oval-tall-slashed'

    capital-a = 'straight-serifless'
    capital-b = 'standard-serifless'
    capital-c = 'serifless'
    capital-d = 'standard-serifless'
    capital-e = 'serifless'
    capital-f = 'serifless'
    capital-g = 'toothless-rounded-serifless-hooked'
    capital-h = 'serifless'
    capital-i = 'serifed'
    capital-j = 'serifed'
    capital-k = 'straight-serifless'
    capital-l = 'serifless'
    capital-m = 'flat-bottom-serifless'
    capital-n = 'standard-serifless'
    capital-p = 'closed-serifless'
    capital-q = 'crossing'
    capital-r = 'straight-serifless'
    capital-s = 'serifless'
    capital-t = 'serifless'
    capital-u = 'toothless-rounded-serifless'
    capital-v = 'straight-serifless'
    capital-w = 'straight-flat-top-serifless'
    capital-x = 'straight-serifless'
    capital-y = 'straight-serifless'
    capital-z = 'straight-serifless'

    a = 'double-storey-serifless'
    b = 'toothed-serifless'
    c = 'serifless'
    d = 'toothed-serifless'
    e = 'flat-crossbar'
    f = 'flat-hook-serifless-crossbar-at-x-height'
    g = 'single-storey-serifless'
    h = 'straight-serifless'
    i = 'serifed'
    j = 'flat-hook-serifed'
    k = 'straight-serifless'
    l = 'serifed-flat-tailed'
    m = 'serifless'
    n = 'straight-serifless'
    p = 'eared-serifless'
    q = 'straight-serifless'
    r = 'compact-serifed'
    s = 'serifless'
    t = 'flat-hook-short-neck'
    u = 'toothed-serifless'
    v = 'straight-serifless'
    w = 'straight-flat-top-serifless'
    x = 'straight-serifless'
    y = 'straight-turn-serifless'
    z = 'straight-serifless'

    [buildPlans.Iosevka${set}.weights]
    Light    = { shape = 300, menu = 300, css = 300 }
    Regular  = { shape = 400, menu = 400, css = 400 }
    Medium   = { shape = 500, menu = 500, css = 500 }
    SemiBold = { shape = 600, menu = 600, css = 600 }
    Bold     = { shape = 700, menu = 700, css = 700 }

    [buildPlans.Iosevka${set}.widths]
    Normal = { shape = 600, menu = 5, css = "normal" }

    [buildPlans.Iosevka${set}.slopes]
    Upright = { shape = "upright", menu = "upright", css = "normal", angle = 0 }
  '';
}
