import { Component, OnInit } from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import { Location } from '@angular/common';

import { Article } from '../article';
import { ArticleService } from '../article.service';

@Component({
  selector: 'app-article-detail',
  templateUrl: './article-detail.component.html',
  styleUrls: [ './article-detail.component.scss' ]
})
export class ArticleDetailComponent implements OnInit {
  article: Article;

  constructor(
    private route: ActivatedRoute,
    private heroService: ArticleService,
    private router: Router,
    private location: Location,
  ) {}

  ngOnInit(): void {
    this.getHero();
  }

  getHero(): void {
    const id = +this.route.snapshot.paramMap.get('id');
    this.heroService.getArticle(id)
      .subscribe(resp => {
        if (resp.data && resp.data.data) {
          this.article = resp.data.data
        } else {
          this.router.navigate(['/articles']);
        }
      });
  }
}
