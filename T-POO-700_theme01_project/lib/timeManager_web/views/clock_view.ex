defmodule TimeManagerWeb.ClockView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.ClockView
  alias TimeManagerWeb.WorkingtimeView

  def render("index.json", %{clock: clock}) do
    %{data: render_many(clock, ClockView, "clock.json")}
  end

  def render("show.json", %{clock: clock}) do
    %{data: render_one(clock, ClockView, "clock.json")}
  end

  def render("clockWork.json", %{clock: clock, workingtime: workingtime}) do
    %{clock: render_one(clock, ClockView, "clock.json"), workingtime: render_one(workingtime, WorkingtimeView, "workingtime.json")}
  end

  def render("clock.json", %{clock: clock}) do
    %{id: clock.id,
      time: clock.time,
      status: clock.status}
  end
end
