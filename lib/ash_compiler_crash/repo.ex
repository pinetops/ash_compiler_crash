defmodule AshCompilerCrash.Repo do
  use Ecto.Repo,
    otp_app: :ash_compiler_crash,
    adapter: Ecto.Adapters.Postgres
end
