{ lib }:
with lib;
with builtins; 
rec {
    pow = base: exp: foldl' (a: x: x * a) 1 (genList (_: base) exp);

    hexToDec = v:
        let
        hexToInt = {
            "0" = 0; "1" = 1;  "2" = 2;
            "3" = 3; "4" = 4;  "5" = 5;
            "6" = 6; "7" = 7;  "8" = 8;
            "9" = 9; "a" = 10; "b" = 11;
            "c" = 12;"d" = 13; "e" = 14;
            "f" = 15;
        };
    chars = stringToCharacters v;
    charsLen = length chars;
    in
        foldl
        (a: v: a + v)
        0
        (imap0
         (k: v: hexToInt."${v}" * (pow 16 (charsLen - k - 1)))
         chars);

    decToHex =
        let
        intToHex = [
        "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
            "a" "b" "c" "d" "e" "f"
        ];
    toHex' = q: a:
        if q > 0
            then (toHex'
                    (q / 16)
                    ((elemAt intToHex (mod q 16)) + a))
        else a;
    in
        v: 
        if v < 16
            then "0" + (elemAt intToHex v)
        else toHex' v "";

    shadeColor = { color, percent ? -10}:
        let
        shade = v: v * (100 + percent) / 100; 
    lowerColor = toLower color;
    R = decToHex (min 255 (max  0 (shade (hexToDec (substring 0 2 lowerColor)))));
    G = decToHex (min 255 (max  0 (shade (hexToDec (substring 2 2 lowerColor)))));
    B = decToHex (min 255 (max  0 (shade (hexToDec (substring 4 2 lowerColor)))));
    in
        R + G + B;
} 
