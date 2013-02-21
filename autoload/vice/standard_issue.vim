" Trim trailing whitespace from a file
func! vice#standard_issue#StripTrailingWhitespace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endf


func! vice#standard_issue#TransparencyToggle()
    if eval("&transparency") == 5
        let &transparency=0
    else
        let &transparency=5
    endif
endf
