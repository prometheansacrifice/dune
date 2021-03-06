(** {1 Raw library descriptions} *)

open Stdune

module Status : sig
  type t =
    | Installed
    | Public  of Package.t
    | Private of Dune_project.Name.t

  val pp : t Fmt.t

  val is_private : t -> bool
end

module Deps : sig
  type t =
    | Simple  of (Loc.t * Lib_name.t) list
    | Complex of Dune_file.Lib_dep.t list

  val of_lib_deps : Dune_file.Lib_deps.t -> t
end

type t = private
  { loc              : Loc.t
  ; kind             : Dune_file.Library.Kind.t
  ; status           : Status.t
  ; src_dir          : Path.t
  ; obj_dir          : Path.t
  ; version          : string option
  ; synopsis         : string option
  ; archives         : Path.t list Mode.Dict.t
  ; plugins          : Path.t list Mode.Dict.t
  ; foreign_archives : Path.t list Mode.Dict.t (** [.a/.lib/...] files *)
  ; jsoo_runtime     : Path.t list
  ; requires         : Deps.t
  ; ppx_runtime_deps : (Loc.t * Lib_name.t) list
  ; pps              : (Loc.t * Dune_file.Pp.t) list
  ; optional         : bool
  ; virtual_deps     : (Loc.t * Lib_name.t) list
  ; dune_version : Syntax.Version.t option
  ; sub_systems      : Dune_file.Sub_system_info.t Sub_system_name.Map.t
  }

val of_library_stanza
  : dir:Path.t
  -> ext_lib:string
  -> Dune_file.Library.t
  -> t

val of_findlib_package : Findlib.Package.t -> t

val user_written_deps : t -> Dune_file.Lib_deps.t
