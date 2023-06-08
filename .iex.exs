import_if_available Ecto
import_if_available Ecto.Query
alias Dxcworld.Repo
alias Dxcworld.Mud.Conn

IEx.configure(
  inspect: [
    limit: :infinity,
    charlists: :as_lists,
    pretty: true,
    binaries: :as_strings,
    printable_limit: :infinity
  ]
)

# IEx.configure(
#   colors: [
#     syntax_colors: [
#       number: :magenta,
#       atom: :cyan,
#       string: :green,
#       boolean: :magenta,
#       nil: :red
#     ],
#     eval_result: [:green, :bright],
#     eval_error: [[:red, :bright, "✘ \n"]],
#     eval_info: [:yellow, :bright],
#     eval_warning: [:yellow, :bright]
#   ]
# )
