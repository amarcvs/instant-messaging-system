Canard::Abilities.for(:admin) do
  can [:create, :update, :read, :destroy], Message
  can [:create, :update, :read, :destroy], Room
  
end
