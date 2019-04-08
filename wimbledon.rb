
def wimbledon(balls)
	# Set variables to be used
	plays = balls.length
	total_plays = 0
	$p1games = 0
	$p1score = "0"
	$p2games = 0
	$p2score = "0"
	$next_player = "P1"
	$serving_player = "P1"
	$next_is_serve = true
	$this_is_serve = true
	$serve1 = true

	# Looping through balls
	balls.each {|x|
		total_plays += 1
		if x # if decision 1 in chart is true
			$next_is_serve = false
			$serve1 = true
			setNextPlayer()

			# Check if this was the last play in the match
			if total_plays == plays # Decision 2 in chart is true
				updateScoreboard()
				return [[$p1games.to_s,$p1score], [$p2games.to_s,$p2score]]
			
			else # Decision 2 in chart is false
				next # This should start a new loop in .each
			end # end of code for decision 2 in chart
		
		else # if decision 1 in chart is false
			$this_is_serve = $next_is_serve
			$next_is_serve = true
			
			if $this_is_serve # Decision 3 in chart is true and this is a serve
				if $serve1 # Decision 4 in chart is true and this is 1st serve
					$serve1 = !$serve1 # change the state of serve1 for next serve
					next # This should start a new loop in .each
				else # Decision 4 in chart is false and this is not 1st serve
					updateScoreboard()
					setServingPlayer()

					# Check if this was the last play in the match
					if total_plays == plays # Decision 5 in chart is true
						return [[$p1games.to_s,$p1score], [$p2games.to_s,$p2score]]
					else # Decision 5 in chart is false
						next # This should start a new loop in .each
					end # end of code for decision 5 in chart

				end # end of code for decision 4 in chart
			else # Decision 3 in chart is false and this is not a serve
				updateScoreboard()
				setServingPlayer()

				# Check if this was the last play in the match
				if total_plays == plays # Decision 5 in chart is true
					return [[$p1games.to_s,$p1score], [$p2games.to_s,$p2score]]
				else # Decision 5 in chart is false
					next # This should start a new loop in .each
				end # end of code for decision 5 in chart
			end # end of code for decision 3 in chart

		end
	} # closing .each loop

	#output
	return [[$p1games.to_s,$p1score], [$p2games.to_s,$p2score]]
end


# External methods to be called from the main wimbledon method
def setNextPlayer
	$next_player == "P1" ? $next_player = "P2" : $next_player = "P1"
end

def setServingPlayer
	$next_player = $serving_player
	$serve1 = true
end

def updateScoreboard
	# $next_player == "P1" ? $p2score +=1 : $p1score +=1

	if $next_player == "P1" # If score is to be added to player 2
		case $p2score
		when "0"
			$p2score = "15"
		when "15"
			$p2score = "30"
		when "30"
			$p2score = "40"
		when "40"
			$p2score = "AD" if $p1score == "40"
			$p2score = "40" && $p1score = "40" if $p1score == "AD"
			
			if $p1score != "40" && $p1score != "AD"
				$serving_player == "P1" ? $serving_player = "P2" : $serving_player = "P1"
				$next_player = $serving_player
				$next_is_serve = true
				$this_is_serve = true
				$serve1 = true
				$p2score = "0"
				$p1score = "0"
				$p2games += 1
			end

		when "AD"
			$serving_player == "P1" ? $serving_player = "P2" : $serving_player = "P1"
			$next_player = $serving_player
			$next_is_serve = true
			$this_is_serve = true
			$serve1 = true
			$p2score = "0"
			$p1score = "0"
			$p2games += 1
		end	
	else # If score is to be added to player 1
		case $p1score
		when "0"
			$p1score = "15"
		when "15"
			$p1score = "30"
		when "30"
			$p1score = "40"
		when "40"
			$p1score = "AD" if $p2score == "40"
			$p1score = "40" && $p2score = "40" if $p2score == "AD"
			
			if $p2score != "40" && $p2score != "AD"
				$serving_player == "P1" ? $serving_player = "P2" : $serving_player = "P1"
				$next_player = $serving_player
				$next_is_serve = true
				$this_is_serve = true
				$serve1 = true
				$p1score = "0"
				$p2score = "0"
				$p1games += 1
			end

		when "AD"
			$serving_player == "P1" ? $serving_player = "P2" : $serving_player = "P1"
			$next_player = $serving_player
			$next_is_serve = true
			$this_is_serve = true
			$serve1 = true
			$p1score = "0"
			$p2score = "0"
			$p1games += 1
		end
	end


end

puts
print wimbledon([true,false,true,false,true,false,true,false,true,false,false,false,false,false])
puts
























