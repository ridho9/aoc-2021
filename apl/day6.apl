plc←~1↓∘≠(⍳8),⍨0,⍨⊢
freq←+⌿∘↑plc¨
adv←{((⊃⍵)×plc 6)+(⊃⍵),⍨1↓⍵}
solve←{16 0⍕+/adv⍣⍺freq⍵}

  80 solve j
      386536
  256 solve j
1732821262171
      