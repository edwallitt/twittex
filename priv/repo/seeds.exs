alias Twittex.Repo
alias Twittex.Accounts
alias Twittex.Feed.Tweek

users =
  for name <- ~w(bill elon jeff mark) do
    username = String.capitalize(name)
    email = name <> "@phoenixonrails.com"
    password = "password1234"
    {:ok, user} = Accounts.register_user(%{username: username, email: email, password: password})
    # Accounts.save_user_avatar!(user, name <> ".png")
    user
  end

for _ <- 1..100 do
  random_days = :rand.uniform(30)
  current_datetime = DateTime.utc_now()
  random_datetime = DateTime.add(current_datetime, -random_days * 24 * 60 * 60, :second)
  truncated_datetime = DateTime.truncate(random_datetime, :second)

  Repo.insert!(%Tweek{
    content: Faker.Lorem.sentence(),
    user_id: Enum.random(users).id,
    inserted_at: truncated_datetime
  })
end
