Red []

{
    https://github.com/red/red
    open a file f
    save a file s
    navigate file system
    move cursor around (vim keys)
    hotkey for evaluation (b or enter)
    font size increase decrease

}

win: view/flags/no-wait/tight layout [ 
    size 1000x700
    a: area
    b: area 
    return 
    c: area {! for f in $(ls .); do echo $f; done}
] [ 'resize ] 

doit: func [ txt ] [
    if txt/1 = #"!" [ 
        out: copy {}
        call/shell/output next txt out
        return out
    ]
    return do txt
]

do-resize: func [] [
    print {resize}
    pane-height: win/size/y - 50
    a/offset: 0x0
    a/size: as-pair win/size/x / 2 pane-height
    b/offset: as-pair win/size/x / 2 0
    b/size: as-pair win/size/x / 2 pane-height

    c/offset: as-pair 0 pane-height
    c/size: as-pair win/size/x 50
    show a
    show b
    show c
]

insert-event-func func [ f e ] [ 
    if e/type = 'resize [ do-resize ]
    if e/type = 'key [
        mod: find e/flags 'command ; modifier key
;        probe e/face
        probe e/key
        probe e/flags
        if all [ mod e/key = #"q" ] [ unview ] 
        if all [ mod e/key = #"^M" ] [ b/text: doit e/face/text show b ]
    ]
    return e 
]
do-resize
do-events

