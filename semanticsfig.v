Reserved Notation " input ↦ output " (at level 50).
Inductive eval: Map r ρ 
              * Map var v
              * Map l T
              * Map l v
              * list l 
              * e 
              → v * list memop
              → Prop := 
  | ERead1 : ∀ M L H S C e l E v,
    (M, L, H, S, C, e) ↦ (vl l, E) →
    l ∉ C → 
    lookup l (apply E S) = Some v → 
    (M, L, H, S, C, read e) ↦ (v, E ++ [mread l v])
  | ERead2 : ∀ M L H S C e l E v,
    (M, L, H, S, C, e) ↦ (vl l, E) →
    l ∈ C → 
    (M, L, H, S, C, read e) ↦ (v, E ++ [mread l v]) 
  | EWrite : ∀ M L H S S' C e1 e2 l E1 E2 E v,
    (M, L, H, S, C, e1) ↦ (vl l, E1) →
    (M, L, H, S', C, e2) ↦ (v, E2) →
    valid_interleave S C E [E1; E2] →
    (M, L, H, S, C, write e1 e2) ↦ (vl l, E ++ [mwrite l v])
  | ENew : ∀ M L H S C t l r, 
    l ∈ lu r M →
    l ∉ domain S →
    (M, L, H, S, C, new t r) ↦ (vl l, [])
  | EUpRgn : ∀ M L H S C e v E rs,
    (M, L, H, S, C, e) ↦ (v, E) →
    (M, L, H, S, C, upr e rs) ↦ (v, E)
  | EColor : ∀ M L H S C K E1 E2 E3 E l e1 e2 e3 v, 
    (M, L, H, S, C, e1) ↦ (vcoloring K, E1) → 
    (M, L, H, apply E1 S, C, e2) ↦ (vl l, E2) → 
    (M, L, H, apply E2 (apply E1 S), C, e3) ↦ (viv v, E3) → 
    valid_interleave S C E [E1; E2; E3] →
    (M, L, H, S, C, color e1 e2 e3) ↦ (vcoloring ((l,v)::K), E) 
	| EPartition : ∀ M M' L H S C rs rp ρs e1 e2 K E' E1 E2 v, 
    (M, L, H, S, C, e1) ↦ (vcoloring K, E1) → 
    ρs = map (map fst) (groupBy (λ x y, beq_nat (snd x) (snd y)) K) →
    M' = zip rs ρs ++ M →  
    (M', L, H, S, C, e2) ↦ (v, E2) →
    valid_interleave S C E' [E1; E2] →
    (M, L, H, S, C, partition rp e1 rs e2) ↦ (v, E')  
  | ECall : ∀ M L H S C es vs Es xs id rs En1 E'' E' M' L' S' C' t ts rs' e Phi Q v, 
    (∀ e v E, In (e, (v, E)) (zip es (zip vs Es)) → (M, L, H, S, C, e) ↦ (v, E)) →
    valid_interleave S C E' Es →
    M' = zip rs' (map (λ r, lu r M) rs) →  
    L' = zip xs vs →
    S' = apply E' S → 
    function id rs xs ts Phi Q t e →
    (M', L', H, S', C', e) ↦ (v, En1) → 
    valid_interleave S C E'' [E'; En1] →
    (M, L, H, S, C, call id rs es) ↦ (v, E'')
    ...


