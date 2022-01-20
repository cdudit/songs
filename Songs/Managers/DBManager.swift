//
//  Persistence.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import CoreData

struct DBManager {
    static let shared = DBManager()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Songs")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: Songs
    func getAllSongs() -> Result<[Song], Error> {
        let fetchRequest: NSFetchRequest<Song> = Song.fetchRequest()
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
        fetchRequest.sortDescriptors = [descriptor]
        
        let context = container.viewContext
        do {
            let songs = try context.fetch(fetchRequest)
            return .success(songs)
        } catch {
            return .failure(error)
        }
    }
    
    func getFavoritesSongs() -> Result<[Song], Error> {
        let fetchRequest: NSFetchRequest<Song> = Song.fetchRequest()
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
        fetchRequest.sortDescriptors = [descriptor]
        fetchRequest.predicate = NSPredicate(format: "isFavorite == %@", NSNumber(value: true))

        let context = container.viewContext

        do {
            let songs = try context.fetch(fetchRequest)
            return .success(songs)
        } catch {
            return .failure(error)
        }
    }
    
    func getSong(by id: NSManagedObjectID) -> Result<Song, Error> {
        let context = container.viewContext
        
        do {
            let song = try context.existingObject(with: id) as! Song
            return .success(song)
        } catch {
            return .failure(error)
        }
    }
    
    @discardableResult
    func unfavoriteSong(for song: Song) -> Result<Song, Error> {
        let context = container.viewContext
        song.isFavorite = false
        
        do {
            try context.save()
            return .success(song)
        } catch {
            return .failure(error)
        }
    }
    
    @discardableResult
    func addSong(
        title: String,
        rate: Int64,
        releaseDate: Date,
        isFavorite: Bool = false,
        lyrics: String?,
        coverURL: URL?
    ) -> Result<Song, Error> {
        let context = container.viewContext
        
        let song = Song(entity: Song.entity(),
                        insertInto: context)
        
        
        let artistsRes = getAllArtists()
        var artist: Artist? = nil
        
        switch artistsRes {
        case .failure: artist = nil
        case .success(let artists): artist = artists.first
        }
        
        song.title = title
        song.releaseDate = releaseDate
        song.rate = rate
        song.isFavorite = isFavorite
        song.coverURL = coverURL
        song.lyrics = lyrics
        song.artist = artist
        
        do {
            try context.save()
            return .success(song)
        } catch {
            return .failure(error)
        }
    }
    
    @discardableResult
    func deleteSong(by id: NSManagedObjectID) -> Result<Void, Error> {
        let context = container.viewContext
        
        do {
            let song = try context.existingObject(with: id)
            context.delete(song)
            try context.save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    // MARK: Artist
    
    @discardableResult
    func deleteArtist(by id: NSManagedObjectID) -> Result<Void, Error> {
        let context = container.viewContext
        
        do {
            let artist = try context.existingObject(with: id)
            context.delete(artist)
            try context.save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }

    @discardableResult
    func addArtist(
        firstName: String,
        lastName: String,
        coverURL: URL,
        songs: [Song]
    ) -> Result<Artist, Error> {
        let context = container.viewContext
        
        let artist = Artist(entity: Artist.entity(), insertInto: context)
        artist.firstName = firstName
        artist.lastName = lastName
        artist.coverURL = coverURL
        artist.songs?.addingObjects(from: songs)
        
        do {
            try context.save()
            return .success(artist)
        } catch {
            return .failure(error)
        }
    }
    
    func addDefaultArtist() {
        let artistResult = getAllArtists()
        
        switch artistResult {
        case .success(let artists):
            if artists.isEmpty {
                addArtist(firstName: "William",
                          lastName: "Nzobazola",
                          coverURL: URL(string: "https://api.lorem.space/image/face?w=150&h=150")!,
                          songs: [])
            }
            
        case .failure: return
        }
    }
    
    func getAllArtists() -> Result<[Artist], Error> {
        let fetchRequest: NSFetchRequest<Artist> = Artist.fetchRequest()
        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "firstName", ascending: true)
        fetchRequest.sortDescriptors = [descriptor]
        
        let context = container.viewContext
        
        do {
            let artists = try context.fetch(fetchRequest)
            return .success(artists)
        } catch {
            return .failure(error)
        }
    }
}
