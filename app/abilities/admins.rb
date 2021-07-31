Canard::Abilities.for(:admin) do
  can [:create, :read, :destroy], Message
  
  can [:create, :read, :destroy], Room
  
end
