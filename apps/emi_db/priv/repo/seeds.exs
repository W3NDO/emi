defmodule Seeder do
  def to_utc_datetime!(date_string) do
    {:ok, datetime, _} = DateTime.from_iso8601("#{date_string}T00:00:00Z")
    datetime
  end
end

alias EmiDb.{PersonInfo, User, SongMetadata, VisualMedia, Repo}



## users
users = [
  %User{username: "Camille", role: "admin"},
  %User{username: "Rabia", role: ""},
  %User{username: "Kristine", role: ""},
  %User{username: "Steven", role: ""}
]

Enum.each(users, fn user -> Repo.insert!(user) end)


## person info
person_info = [
  %PersonInfo{full_name: "Nura Habib Omer",
    date_of_birth: Seeder.to_utc_datetime!("1988-12-24"),
    nationality: "German",
    bio: "Nura Habib Omer (Arabic: نورا حبيب عمر, born 24 December 1988[1]) is a Kuwait-born German rapper and actor of Eritrean descent.[2] She is known for being part of The toten Crackhuren im Kofferraum and the rap duo SXTN.[3] Following the split of SXTN in 2018, she has pursued a solo career.[4] As an actor she is best known for playing Flora in the Amazon Prime Video series Die Discounter",
    role: "Artist",
    aliases: "",
    gender: "female",
    image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Nura_-_Openair_Frauenfeld_2019_06.jpg/250px-Nura_-_Openair_Frauenfeld_2019_06.jpg",
    imdb_id: "nm7693815",
    social_links: "",
    awards: ""},
  %PersonInfo{
    full_name: "Hayao Miyazaki",
    date_of_birth: Seeder.to_utc_datetime!("1941-01-05"),
    nationality: "Japanese",
    bio: "Co-founder of Studio Ghibli, renowned director and animator.",
    role: "Director",
    aliases: "Miyazaki-san",
    gender: "Male",
    image_url: "https://example.com/miyazaki.jpg",
    imdb_id: "nm0594503",
    social_links: "",
    awards: "Academy Honorary Award"
  },
  %PersonInfo{
    full_name: "Christopher Nolan",
    date_of_birth: Seeder.to_utc_datetime!("1970-07-30"),
    nationality: "British-American",
    bio: "Director known for non-linear storytelling and high-concept films.",
    role: "Director",
    aliases: "",
    gender: "Male",
    image_url: "https://example.com/nolan.jpg",
    imdb_id: "nm0634240",
    social_links: "",
    awards: "Oscar nominee, BAFTA winner"
  },
  %PersonInfo{
    full_name: "Scarlett Johansson",
    date_of_birth: Seeder.to_utc_datetime!("1984-11-22"),
    nationality: "American",
    bio: "Actress known for roles in Lost in Translation and Marvel films.",
    role: "Actor",
    aliases: "ScarJo",
    gender: "Female",
    image_url: "https://example.com/scarlett.jpg",
    imdb_id: "nm0424060",
    social_links: "https://instagram.com/scarlettj",
    awards: "BAFTA Best Actress"
  },
  %PersonInfo{
    full_name: "Bong Joon-ho",
    date_of_birth: Seeder.to_utc_datetime!("1969-09-14"),
    nationality: "South Korean",
    bio: "Director and screenwriter behind Parasite and Snowpiercer.",
    role: "Director",
    aliases: "",
    gender: "Male",
    image_url: "https://example.com/bong.jpg",
    imdb_id: "nm0094435",
    social_links: "",
    awards: "Academy Award for Best Director"
  },
  %PersonInfo{
    full_name: "Emma Watson",
    date_of_birth: Seeder.to_utc_datetime!("1990-04-15"),
    nationality: "British",
    bio: "Actress and activist best known for playing Hermione Granger.",
    role: "Actor",
    aliases: "",
    gender: "Female",
    image_url: "https://example.com/emma.jpg",
    imdb_id: "nm0914612",
    social_links: "https://twitter.com/emmawatson",
    awards: "MTV Trailblazer Award"
  }
]

Enum.each(person_info, fn person -> Repo.insert!(person) end)

## Visual Media

visual_media_entries = [
  %VisualMedia{
    title: "Spirited Away",
    original_title: "千と千尋の神隠し",
    synopsis: "A young girl enters a world of spirits and must find her way back.",
    release_date: Seeder.to_utc_datetime!("2001-07-20"),
    language: "Japanese",
    country: "Japan",
    status: "Released",
    backdrop_url: "https://example.com/spirited_away.jpg",
    keywords: "spirits, bathhouse, adventure",
    rating: "PG",
    tags: "anime, fantasy, coming-of-age"
  },
  %VisualMedia{
    title: "Inception",
    original_title: "Inception",
    synopsis: "A thief steals corporate secrets through dream invasion.",
    release_date: Seeder.to_utc_datetime!("2010-07-16"),
    language: "English",
    country: "USA",
    status: "Released",
    backdrop_url: "https://example.com/inception.jpg",
    keywords: "dreams, subconscious, heist",
    rating: "PG-13",
    tags: "thriller, sci-fi, mind-bending"
  },
  %VisualMedia{
    title: "Parasite",
    original_title: "기생충",
    synopsis: "A poor family schemes to become employed by a wealthy family.",
    release_date: Seeder.to_utc_datetime!("2019-05-30"),
    language: "Korean",
    country: "South Korea",
    status: "Released",
    backdrop_url: "https://example.com/parasite.jpg",
    keywords: "class, deception, family",
    rating: "R",
    tags: "drama, satire, thriller"
  },
  %VisualMedia{
    title: "The Matrix",
    original_title: "The Matrix",
    synopsis: "A hacker discovers the world is a simulated reality.",
    release_date: Seeder.to_utc_datetime!("1999-03-31"),
    language: "English",
    country: "USA",
    status: "Released",
    backdrop_url: "https://example.com/matrix.jpg",
    keywords: "simulation, hacker, rebellion",
    rating: "R",
    tags: "sci-fi, action, cyberpunk"
  },
  %VisualMedia{
    title: "Your Name",
    original_title: "君の名は。",
    synopsis: "Two teenagers mysteriously swap bodies and try to meet.",
    release_date: Seeder.to_utc_datetime!("2016-08-26"),
    language: "Japanese",
    country: "Japan",
    status: "Released",
    backdrop_url: "https://example.com/your_name.jpg",
    keywords: "body swap, connection, memory",
    rating: "PG",
    tags: "romance, anime, fantasy"
  }
]

Enum.each(visual_media_entries, fn vm -> Repo.insert!(vm) end)


## Song Metadata
song_metadata = [
  %SongMetadata{
    title: "Blue Bird",
    release_date: Seeder.to_utc_datetime!("2008-07-02"),
    single: true,
    length: 225,
    tags: "anime,naruto,opener",
    genres: "J-pop,Rock",
    poster_url: "https://example.com/blue_bird.jpg",
    producing_studio: "Sony Music Japan"
  },
  %SongMetadata{
    title: "Unravel",
    release_date: Seeder.to_utc_datetime!("2014-07-23"),
    single: true,
    length: 260,
    tags: "anime,tokyo ghoul",
    genres: "Alternative Rock",
    poster_url: "https://example.com/unravel.jpg",
    producing_studio: "Sony Music Records"
  },
  %SongMetadata{
    title: "Gurenge",
    release_date: Seeder.to_utc_datetime!("2019-07-03"),
    single: true,
    length: 230,
    tags: "anime,demon slayer",
    genres: "Pop Rock",
    poster_url: "https://example.com/gurenge.jpg",
    producing_studio: "SACRA MUSIC"
  },
  %SongMetadata{
    title: "Tank!",
    release_date: Seeder.to_utc_datetime!("1998-05-21"),
    single: false,
    length: 210,
    tags: "anime,cowboy bebop,jazz",
    genres: "Jazz,Big Band",
    poster_url: "https://example.com/tank.jpg",
    producing_studio: "Victor Entertainment"
  },
  %SongMetadata{
    title: "Silhouette",
    release_date: Seeder.to_utc_datetime!("2014-11-26"),
    single: true,
    length: 248,
    tags: "anime,naruto shippuden",
    genres: "Rock",
    poster_url: "https://example.com/silhouette.jpg",
    producing_studio: "Toy's Factory"
  }
]

Enum.each(song_metadata, fn song -> Repo.insert(song) end)
