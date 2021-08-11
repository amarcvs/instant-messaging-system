Canard::Abilities.for(:messagewriter) do
  can [:create], Message
  cannot [:update, :read, :destroy], Message
  cannot [:create, :update, :read, :destroy], Room
  
end
