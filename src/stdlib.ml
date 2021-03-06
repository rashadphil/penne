open Context

let printf_fn = 
  let printf_t = Llvm.var_arg_function_type i32_type [|ch_ptr|] in
  Llvm.declare_function "printf" printf_t the_module

(* format strings need to be built in main/function bb (LLVM Bug?) *)
let gen_print_int () = 
  let format_str = Llvm.build_global_stringptr "%d\n" "fmt" main_builder in
  let print_int_type = Llvm.function_type i32_type [|i32_type|] in
  let print_int_fn = declare_fn "print_int" print_int_type in
    (make_bb print_int_fn : _) |> ignore;
  let int_val = Llvm.param print_int_fn 0 in
  call printf_fn [|format_str; int_val|] |> finish_fn

(* Not Implemented *)
let gen_len () =
  let len_t = Llvm.var_arg_function_type  i32_type [|i32_type|] in 
  let len_fn = declare_fn "len" len_t in
    (make_bb len_fn: _ ) |> ignore;
  debug_val |> finish_fn


