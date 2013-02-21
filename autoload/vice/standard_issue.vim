" Trim trailing whitespace from a file
func! vice#standard_issue#StripTrailingWhitespace()
    normal mZ
    %s/\s\+$//e
    normal `Z
endf
