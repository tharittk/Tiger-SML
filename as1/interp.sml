structure Interp = struct

    structure S = SLP
    (* Use S.CompoundStm, S.Plus, S.IdExp, etc. to refer to
     * items defined in structure SLP (see slp.sml) *)
    
    type table = (S.id * int) list

    fun update(tbl, ident, newval) = (ident, newval)::tbl
    (*assume the first occurrence of any id takes precedence
      over any later occurrences in the table*)

    exception UndefinedVariable of string

    fun lookup (tbl:table, ident) = 
          case tbl of 
            nil => raise UndefinedVariable(ident)
          | (x, xval)::xs => if ident=x then xval
			     else lookup(xs, ident)

    exception InterpUnimplemented

    fun interpOp S.Plus  = Int.+
      | interpOp S.Minus = Int.-
      | interpOp S.Times = Int.*
      | interpOp S.Div   = Int.div

    fun interpStm (s:S.stm, tbl:table) = 
          raise InterpUnimplemented (* fix me! *)
    and interpExp (e:S.exp, tbl:table) = 
          raise InterpUnimplemented (* fix me! *)

    fun interp s = 
          (interpStm(s, nil); ())
end
