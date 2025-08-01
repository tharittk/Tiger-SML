structure Compile : sig val compile: string -> unit end =
struct 
  exception Stop
  fun still_ok () = if (!ErrorMsg.anyErrors) then raise Stop else ()

  fun compile filename = 
    let
	val _ = Mips.reset()
	val absyn = Parse.parse filename
        val () = still_ok()
        val () = TypeCheck.tc absyn
        val () = still_ok()
        (* val _ = print "Program successfully typechecked\n" *)
        (* val _ = FunPP.print_prog absyn *)
	val (strBL, funCodeL) = Codegen.codegen absyn
	val out' = TextIO.openOut (filename^".noregalloc.s")
	val _ = Mips.printAssem(out', (strBL, funCodeL)) 
                before TextIO.closeOut out'
         	handle e => (TextIO.closeOut out'; raise e)

        (* val igraph = Liveness.liveness (strBL, funCodeL) *)

	val funCodeL' = List.map RegAlloc.alloc funCodeL

	val out = TextIO.openOut (filename^".s") 

    in 
	Mips.printAssem(out, (strBL, funCodeL')) before TextIO.closeOut out
	handle e => (TextIO.closeOut out; raise e)

    end
 handle ErrorMsg.Error => print "\nCompiler bug.\n\n" 
      | Stop => print "\nCompilation Failed.\n\n" 
end