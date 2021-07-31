Canard::Abilities.for(:messagewriter) do
  can [:create], Message
  
  can [:create, :destroy, :update], Room
  
end
