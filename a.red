Red []

{
    https://github.com/red/red
    open a file f
    save a file s
    navigate file system
    move cursor around (vim keys)
    hotkey for evaluation (b or enter)
    font size increase decrease



    Goal: edit this file in the editor

    *** Script Error: VIEW - face not linked to a window
    *** Where: do
    *** Stack: context do-events do-safe show cause-error 
    == make object! [
    win: make object! [
        type: 'window
        offset: 220x100
    ...


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

{
focus-next: func [ e ] [
    place: next find win/pane e/face 
    if tail? place [ place: head place ] 
    set-focus place/1 
]
}

insert-event-func func [ f e ] [ 
    if e/type = 'resize [ do-resize ]
    if e/type = 'key [
        command: find e/flags 'command
        control: find e/flags 'control
;        probe e/face
        probe e/key
        probe e/flags
        if all [ command e/key = #"q" ] [ unview ] 
        if all [ command e/key = #"^M" ] [ b/text: doit e/face/text show b ]
        ; if all [ control e/key = #"^-" ] [  focus-next e ]
    ]
    return e 
]
do-resize
do-events

