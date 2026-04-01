//
//  DependecyContainer.swift
//  VideoOnThemand
//
//  Created by Michele Manniello on 31/03/26.
//

import Foundation

class DependecyContainer {
    
    //MARK: Repository
    private lazy var chronologyRepository: ChronologyRepositoryProtocol = {
        ChronologyRepository()
    }()
    
    private lazy var movieRepository: MovieRepositoryProtocol = {
        return  MovieRepository()
    }()
    
    private lazy var authRepository: AuthRepositoryProtocol = {
        return AuthRepository()
    }()
    
    private lazy var credentialRepository: CredentialRepositoryProtocol = {
        return CredentialRepository()
    }()
    
    //MARK: Repository
    private lazy var fetchChronologyUseCase: FetchChronologyUseCase = {
        FetchChronologyUseCase(chronologyRepository: chronologyRepository)
    }()
    
    private lazy var updateChronologyUseCase: UpdateChronologyUseCase = {
        UpdateChronologyUseCase(chronologyRepository: chronologyRepository)
    }()
    
    private lazy var fetchMovieUseCase: FetchMovieUseCase = {
        return FetchMovieUseCase(movieRepository: movieRepository)
    }()
    
    private lazy var getCurrentUseCase: GetCurrentUserUseCase = {
        return GetCurrentUserUseCase(authRepository: authRepository,
                                     credentialRepository: credentialRepository)
    }()
    
    private lazy var logoutUseCase: LogoutUseCase = {
        return LogoutUseCase(repository: authRepository)
    }()
    
    private lazy var loginUseCase: LoginUseCase = {
        return LoginUseCase(authRepository: authRepository,
                            credentialRepository: credentialRepository)
    }()
    
    private lazy var restoreSessionUseCase: RestoreSessionUseCase = {
        return RestoreSessionUseCase(repository: credentialRepository)
    }()
    
    // MARK: VIEWModel
    
    let sessionManager = SessionManager()
    
    @MainActor func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(loginUseCase: loginUseCase,
                       logoutUseCase: logoutUseCase,
                       restoreSessionUseCasse: restoreSessionUseCase)
    }
    
    @MainActor func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(updateChronologyUseCase: updateChronologyUseCase,
                      fetchMovieUseCase: fetchMovieUseCase,
                      getCurrentUserUseCase: getCurrentUseCase,
                      sessionManager: sessionManager)
    }
    
    @MainActor func makeChronologyViewModel() -> ChronologyViewModel {
        ChronologyViewModel(fetchChronologyUseCase: fetchChronologyUseCase,
                            sessionManager: sessionManager)
    }
    
}
