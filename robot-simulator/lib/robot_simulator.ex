defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @directions [
    :north,
    :east,
    :south,
    :west
  ]

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0,0}) do
    cond do
      position_invalid(position) -> {:error, "invalid position"}
      Enum.find(@directions,&(&1 == direction)) == nil -> {:error, "invalid direction"}
      true -> %{direction: direction , position: position}
    end
  end

  def position_invalid({x,y}) do
    !(is_integer(x) && is_integer(y))
  end

  def position_invalid(_) do
    true
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
      |>String.graphemes()
      |>move(robot)
  end

  def move([], robot) do
    robot
  end

  def move([head|tail], robot) do
    case head do
      "A" -> calc_position(tail,robot)
      "L" -> move(tail, calc_direction(robot,-1))
      "R" -> move(tail, calc_direction(robot,+1))
      _ ->  {:error, "invalid instruction"}
    end
  end

  def calc_position(instrutions,robot) do
    case robot.direction do
      :north -> move(instrutions,Map.replace!(robot,:position, {elem(robot.position,0),elem(robot.position,1)+1}))
      :west-> move(instrutions,Map.replace!(robot,:position, {elem(robot.position,0)-1,elem(robot.position,1)}))
      :south-> move(instrutions,Map.replace!(robot,:position, {elem(robot.position,0),elem(robot.position,1)-1}))
      :east-> move(instrutions,Map.replace!(robot,:position, {elem(robot.position,0)+1,elem(robot.position,1)}))
    end
  end

  def calc_direction(robot,direction) do
    index = Enum.with_index(@directions)[robot.direction] + direction
    if index > 3 do
      Map.replace!(robot,:direction, Enum.at(@directions, 0))
    else
      Map.replace!(robot,:direction, Enum.at(@directions, index))
    end
  end


  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
