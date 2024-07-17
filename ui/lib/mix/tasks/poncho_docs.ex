defmodule Mix.Tasks.PonchoDocs do
  use Mix.Task

  @paths [
    "../one/lib/*",
    "../two/lib/*"
  ]

  @impl Mix.Task
  def run(_args) do
    Mix.Shell.IO.info("Generating new poncho docs!")

    # Iterate paths and copy files inside those paths
    Enum.each(@paths, &Mix.Shell.cmd("cp #{&1} ./lib/temp/", fn _x -> nil end))

    # Generate new docs
    Mix.Shell.cmd("mix docs", fn _x -> nil end)

    # Purge copied files
    Mix.Shell.cmd("rm ./lib/temp/*", fn _x -> nil end)
  end
end
