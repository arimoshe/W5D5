def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.

  # movies = Movie.select(:title, :id).joins(:actors).where("actors.name IN (?)",those_actors).includes(:actors)
  # out = {}
  # those_actors.all?  {|actor| movies.actors.include?(actor)}
  
  # movies =  Movie.select(:title, :id).joins(:actors).where("actors.name IN (?)",those_actors)#.includes(:actors)

  # movies.select {|movie| movie.actors.where("actors.name IN (?)",those_actors).length == those_actors.length}

  Movie.select(:title, :id).joins(:actors).where("actors.name IN (?)",those_actors).group(:id).having("COUNT(*) = ?", those_actors.length)

end

def golden_age
  # Find the decade with the highest average movie score.
  # HINT: Use a movie's year to derive its decade. Remember that you can use
  # arithmetic expressions in SELECT clauses.
  Movie.select("CAST(floor(yr/10)*10 as integer) decade ").group("decade").order("AVG(score) desc").limit(1)[0].decade
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  # Hint: use a subquery
  
  
  movies = Movie.joins(:actors).where("actors.name = ?",name).pluck(:id).uniq
 Actor.joins(:movies).where("movies.id IN (?)",movies).where.not(:name => name).distinct.pluck(:name)

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie.
  Actor.left_outer_joins(:movies).where("movies.id is NULL").group(:id).pluck(:id).count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`. A name is
  # like whazzername if the actor's name contains all of the letters in
  # whazzername, ignoring case, in order.

  # E.g., "Sylvester Stallone" is like "sylvester" and "lester stone" but not
  # like "stallone sylvester" or "zylvester ztallone".
  matcher = "%#{whazzername.split("").join("%")}%"
  Movie.joins(:actors).where("name ILIKE ?", matcher)
end

def longest_career
  # Find the 3 actors who had the longest careers (i.e., the greatest time
  # between first and last movie). Order by actor names. Show each actor's id,
  # name, and the length of their career.
  
end