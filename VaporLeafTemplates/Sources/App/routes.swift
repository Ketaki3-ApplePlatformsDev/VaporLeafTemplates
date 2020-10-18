import Vapor

struct Context: Content {
//    let name: String
//    let age: Int
    let movies: [Movie]
}

struct Review: Content {
    let title: String
    let rating: Int
}

struct Movie: Content {
    var name: String
    var reviews: [Review] = [Review]()
    
}

func routes(_ app: Application) throws {
  
    // localhost:8080/
    app.get { request -> EventLoopFuture<View> in
//        request.view.render("index", Context(name: "John Doe", age: 34))
        var movie = Movie(name: "Lord of the Rings")
        let reviews = [Review(title: "Great movie!", rating: 5), Review(title: "Amazing scenery", rating: 5)]
        movie.reviews = reviews
        
        let context = Context(movies: [movie])
        return request.view.render("index", context)
    }
    
    app.get("about-us") { request -> EventLoopFuture<View> in
        request
            .view.render("about-us")
    }

    app.post("add-movie") { request -> Response in
        let movie = try request.content.decode(Movie.self)
        //Write code to save movie to database
        print(movie)
        return request.redirect(to: "/")
    }
}
