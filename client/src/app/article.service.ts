import {Injectable} from '@angular/core';
import {HttpClient, HttpHeaders} from '@angular/common/http';

import {Observable, of} from 'rxjs';
import {catchError} from 'rxjs/operators';

import {Article} from './article';
import { environment } from './../environments/environment';


@Injectable({providedIn: 'root'})
export class ArticleService {

  private articlesUrl = `${environment.apiUrl}/api/news`;  // URL to web api

  httpOptions = {
    headers: new HttpHeaders({'Content-Type': 'application/json'})
  };

  constructor(
    private http: HttpClient) {
  }

  /** GET articles from the server */
  getArticles(page: number): Observable<any> {
    return this.http.get<any>(this.articlesUrl + `?page=${page}`)
      .pipe(
        catchError(this.handleError<Article[]>('getArticles', []))
      );
  }

  /** GET article by id. */
  getArticle(id: number): Observable<any> {
    const url = `${this.articlesUrl}/${id}`;
    return this.http.get<any>(url).pipe(
      catchError(this.handleError<Article>(`getArticle id=${id}`))
    );
  }

  /**
   * Handle Http operation that failed.
   * Let the app continue.
   * @param operation - name of the operation that failed
   * @param result - optional value to return as the observable result
   */
  private handleError<T>(operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {
      // TODO: send the error to remote logging infrastructure
      console.error(error); // log to console instead
      // Let the app keep running by returning an empty result.
      return of(result as T);
    };
  }
}
