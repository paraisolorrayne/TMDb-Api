//
//  api_Key.h
//  TMDb-Api
//
//  Created by Lorrayne Paraisoa on 24/03/17.
//  Copyright © 2017 DevTech. All rights reserved.
//

#ifndef api_Key_h
#define api_Key_h


#endif /* api_Key_h */
/*

 Chave da API (v3 auth)
 
 625a7cbd9e0ae06da951620f6f0015d1
 
 Token de Leitura da API (v4 auth)
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MjVhN2NiZDllMGFlMDZkYTk1MTYyMGY2ZjAwMTVkMSIsInN1YiI6IjU4ZDI4OWI3OTI1MTQxMWFmNDAyMDFmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PBEWV2bJThrDncjp314r3Ke_udps4Sp5UePZJ44iRGI
 
 Solicitação de exemplo de API
 
 https://api.themoviedb.org/3/movie/550?api_key=625a7cbd9e0ae06da951620f6f0015d1


 
 
 https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&api_key=%3C%3Capi_key%3E%3E
 
 
 
 Base url: https://api.themoviedb.org/3/
 
 
 Populares: https://api.themoviedb.org/3/movie/popular?page=1&language=pt-BR&api_key=625a7cbd9e0ae06da951620f6f0015d1
 
 Busca genérica por nome do filme sem passar a chave:
 
 https://www.themoviedb.org/search?query=matrix
 
 https://www.themoviedb.org/search?query=star+wars
 
 Url da busca de filmes por nome:
 https://api.themoviedb.org/3/search/movie?api_key=625a7cbd9e0ae06da951620f6f0015d1&query=matrix
 
 Url dos detalhes do filme de acordo com o id 603:
 https://api.themoviedb.org/3/movie/603?api_key=625a7cbd9e0ae06da951620f6f0015d1
 
 Url base youtube trailer:
 https://www.youtube.com/watch?v=(keydovideo)
 Url que pega os vídeos do filme de acordo com o id:
 https://api.themoviedb.org/3/movie/343611?api_key=625a7cbd9e0ae06da951620f6f0015d1&append_to_response=videos

 
 
 static NSString *const kUrlBase = @"https://api.themoviedb.org/3/";
 static NSString *const kApiKey = @"625a7cbd9e0ae06da951620f6f0015d1";
 static NSString *const kToken = @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MjVhN2NiZDllMGFlMDZkYTk1MTYyMGY2ZjAwMTVkMSIsInN1YiI6IjU4ZDI4OWI3OTI1MTQxMWFmNDAyMDFmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PBEWV2bJThrDncjp314r3Ke_udps4Sp5UePZJ44iRGI";
 static NSString *const kSearchMovieWithKey = @"search/movie?api_key=";
 NSString *const kTMDBPopularPath = @"movie/popular?page=1&language=pt-BR&api_key=625a7cbd9e0ae06da951620f6f0015d1";
 NSString *const kTMDbConfigurationPath = @"configuration";
 NSString *const kTMDbConfigurationImagesKey = @"images";
 NSString *const kTMDbConfigurationImagesBaseUrlKey = @"base_url";
 NSString *const kTMDbGenreListPath = @"genre/list";
 NSString *const kTMDbGenreMoviesPath = @"genre/:id/movies";
 NSString *const kTMDbMovieSearchPath = @"search/movie";
 NSString *const kTMDbMoviePath = @"movie/:id";
 NSString *const kTMDbMovieCastsPath = @"movie/:id/casts";
 NSString *const kTMDbMovieImagesPath = @"movie/:id/images";
 NSString *const kTMDbMovieTrailersPath = @"movie/:id/trailers";
 NSString *const kTMDbMovieSimilarPath = @"movie/:id/similar_movies";
 NSString *const kTMDbMovieUpcomingPath = @"movie/upcoming";
 NSString *const kTMDbMovieTheatresPath = @"movie/now_playing";
 NSString *const kTMDbMovieTopRatedPath = @"movie/top_rated";
 NSString *const kTMDbPersonPath = @"person/:id";
 NSString *const kTMDbPersonSearchPath = @"search/person";
 NSString *const kTMDbPersonPopularPath = @"person/popular";
 NSString *const kTMDbPersonNameKey = @"name";
 NSString *const kTMDbPersonBiographyKey = @"biography";
 NSString *const kTMDbPersonCreditsKey = @"credits";
 NSString *const kTMDbPersonCreditsImagePathKey = @"poster_path";
 NSString *const kTMDbPersonImagePathKey = @"profile_path";
 NSString *const kTMDbPersonPlaceOfBirthKey = @"place_of_birth";
 NSString *const kTMDbPersonBirthDayKey = @"birthday";
 NSString *const kTMDbPersonDeathDayKey = @"deathday";
 NSString *const kTMDbPersonCreditsCastKey = @"cast";
 NSString *const kTMDbPersonCreditsCrewKey = @"crew";
 NSString *const kTMDbPersonCreditsCastReleaseDateKey = @"release_date";
 NSString *const kTMDbPersonCreditsCastTitleKey = @"original_title";
 NSString *const kTMDbPersonTVCreditsKey = @"tv_credits";
 NSString *const kTMDbPersonTVCreditsCastTitleKey = @"original_name";
 NSString *const kTMDbSearchParamQueryKey = @"query";
 NSString *const kTMDbSearchParamTypeKey = @"search_type";
 NSString *const kTMDbSearchParamTypeNgram = @"ngram";
 NSString *const kTMDbSearchParamTypePhrase = @"phrase";
 NSString *const kTMDbSearchResultsKey = @"results";
 NSString *const kTMDbSearchResultsObjectIdKey = @"id";
 NSString *const kTMDbObjectIdKey = @"id";
 
 */
