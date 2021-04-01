import { Component, OnInit } from '@angular/core';

import { Article } from '../article';
import { ArticleService } from '../article.service';

@Component({
  selector: 'app-articles',
  templateUrl: './articles.component.html',
  styleUrls: ['./articles.component.scss']
})
export class ArticlesComponent implements OnInit {
  articles: Article[] = [];
  currentPage: number = 0;
  totalPage: number = 0;
  constructor(private articleService: ArticleService) { }

  ngOnInit() {
    this.getArticles(this.currentPage);
  }

  getArticles(page): void {
    this.articleService.getArticles(page)
    .subscribe(resp => {
      if (resp.data && resp.data.data && resp.data.data.length > 0) {
        this.articles = resp.data.data;
        this.currentPage = resp.data.page;
        this.totalPage = resp.data.total_pages;
      }
    });
  }

  strip(html) {
    let tmp = document.createElement("div");
    tmp.innerHTML = html;
    return tmp.textContent || tmp.innerText;
  }

  prevPage() {
    if (this.currentPage - 1 < 0) {
      return
    }
    this.currentPage = this.currentPage - 1;
    this.getArticles(this.currentPage);
  }

  nextPage() {
    if (this.currentPage == this.totalPage - 1) {
      return
    }
    this.currentPage = this.currentPage + 1;
    this.getArticles(this.currentPage);
  }
}
