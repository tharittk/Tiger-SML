signature REWRITE =
sig
  val rename_prog: Absyn.prog -> Absyn.prog
  val cfold_prog : Absyn.prog -> Absyn.prog
end

structure Rewrite :> REWRITE =
struct

 structure A = Absyn
 structure S = Symbol
     
 type env = S.symbol S.table

 fun bind (rho:env, id : S.symbol) : env * S.symbol =
   (* replace this stub with something useful *)
        (rho, id)

 fun rename_prog (fds : A.prog): A.prog  = 
   (* replace this stub with something useful *)
      fds


 fun cfold_prog p = 
   (* replace this stub with something useful *)
        p

end
