structure MaxArg = struct

    structure S = SLP
    (* Use S.CompoundStm, S.Plus, S.IdExp, etc. to refer to
     * items defined in structure SLP (see slp.sml) *)

    exception MaxUnimplemented

    fun maxarg s = 
      case s of
        S.CompoundStm(s1, s2) =>
          let val args1 = maxarg s1
	      val args2 = maxarg s2
	  in Int.max (args1, args2)
	  end
      | S.AssignStm(x, e) => raise MaxUnimplemented (* change me!! *)
      | S.PrintStm elist =>  raise MaxUnimplemented (* change me!! *)

    and maxExpArg e =
      case e of
        S.IdExp _ => 0
      | _ =>  raise MaxUnimplemented (* change me and extend cases!! *) 
end
