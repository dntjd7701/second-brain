# Spring Data Elasticsearch Operations Null Failure

## 증상

Spring Boot 기동 중 다음 형태의 예외가 발생한다.

```text
PropertyAccessException 1: org.springframework.beans.MethodInvocationException:
Property 'elasticsearchOperations' threw exception;
nested exception is java.lang.IllegalArgumentException:
ElasticsearchOperations must not be null!
```

## 확인된 원인 구조

`amaranth10-reception`의 `ElasticsearchConfig`는 `@EnableElasticsearchRepositories`에서 `elasticsearchTemplateRef = "elasticsearchOperations"`를 지정한다.

동시에 `elasticsearchOperations()` 빈 생성 메서드는 `ElasticsearchClient`가 없으면 `null`을 반환한다. `elasticsearchClient()`도 인증서 파일 없음 또는 생성 실패 시 `null`을 반환한다.

Spring Data Elasticsearch RepositoryFactoryBean은 `ElasticsearchOperations`가 반드시 실제 객체여야 하며, `null`을 허용하지 않는다. 따라서 ES를 "비활성화"하기 위해 `@Bean` 메서드에서 `null`을 반환하면 Repository 자동 등록 단계에서 기동 실패가 난다.

## 진단 포인트

- `@EnableElasticsearchRepositories`가 켜져 있으면 Repository 빈 생성이 먼저 강제된다.
- Repository가 등록되는 동안 `elasticsearchOperations` 참조 빈이 `null`이면 `ElasticsearchOperations must not be null!`이 발생한다.
- ES 연결 실패 자체보다, `@Bean`에서 `null`을 반환한 설계가 직접 원인이다.
- SSL 사용 시 인증서 경로가 런타임의 `user.dir` 기준으로 존재하는지 확인해야 한다.

## 재발 방지 전략

- `@Bean` 메서드에서 기능 비활성화를 표현하려고 `null`을 반환하지 않는다.
- ES를 옵션 기능으로 둘 경우 `@ConditionalOnProperty` 등으로 `ElasticsearchConfig`와 `@EnableElasticsearchRepositories` 자체를 조건부 등록한다.
- Repository를 항상 주입해야 하는 서비스는 ES 비활성 상태에서 함께 빠지게 하거나, Repository 직접 주입 대신 ES 활성 상태에서만 실행되는 구조로 나눈다.
- 인증서 파일은 `${user.dir}/src/main/resources/...`처럼 개발 실행 경로에 민감한 경로보다 classpath resource 또는 배포 환경의 명시 경로로 관리한다.

## 관련 코드

- `/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-reception/src/main/java/com/amaranth10/common/config/ElasticsearchConfig.java`
- `/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-reception/src/main/java/com/amaranth10/common/elasticsearch/repository/PatientRepository.java`
- `/Users/woosung/Desktop/Amaranth10/3.Boot/amaranth10-reception/src/main/java/com/amaranth10/common/kafka/service/PatientToEsSyncService.java`
