-----------------------------------------------------------------------------
--
-- 3 표현식
--
-----------------------------------------------------------------------------
--
-- 3.1 산술 연산자
--
-- 나머지 연산의 정의는 다음과 같다.
-- > a%b == a - math.floor(a/b)*b
--
-- 피연산자가 실수인 경우에는 x%1은 x의 소수점 이하를 결과로 낸다.(1로 나눈 나머지이니 소수점만)
-- 그래서 x - x%1의 결과는 x의 정수 부분이 됨. (x에서 소수점만 제외)
-- 마찬 가지로 x - x%0.01은 x의 소수점 이하 두자리까지가 결과로 나온다. (소수점 셋째자리 밑으로를 빼버림)
--
x = math.pi
print(x - x%0.01)	--> 3.14
-- 
-- 임의의 각도를 [0, 2π]로 나타낼 때도 angle % (2 * math.pi) 연산으로 해결
--
-----------------------------------------------------------------------------
--
-- 3.2 비교 연산
--
-- 루아에서 !=는 ~=으로 사용
-- 피연산자의 타입이 서로 다르면 같지 않음으로 판단
-- nil은 오직 nil과 같다.
-- 테이블과 유저데이터의 동등성은 참조 값이 같은지로 판단
--
a = {} a.x=1 a.y=0
b = {} b.x=1 b.y=0
c = a 			--> a==c지만 a~=b
--
-- "0"과 0은 다르다
-- 2<15지만 "2"<"15"는 알파벳 순으로 거짓이므로 비교할 때 조심해야함 
-- 
-----------------------------------------------------------------------------
--
-- 3.3 논리 연산자
--
-- and, or, not 존재
-- false나 nil은 거짓. 그 외에는 모두 참
-- and 연산자는 참인 경우 2번째 인자 반환, 거짓인 경우 1번째 인자 반환
-- or 연산자는 참인 경우 1번째 인자 반환, 거짓이면 2번째 인자 반환
--
print(4 and 5)		--> 5
print(nil and 13)	--> nil
print(false and 13)	--> false
print(4 or 5)		--> 4
print(false or 5)	--> 5
--
-- and와 or에는 단축 계산이 적용되어. 두번째 피연산자는 필요할 때만 계산됨
-- type(v) == "table" and v.tag == "hi"
-- 와 같이 사용하여도 오류가 발생하지 않게 보장
--
-- max = (x>y) and x or y  -->  x>y? x : y로 생각
--
-----------------------------------------------------------------------------
--
-- 3.4 이어 붙이기
--
-- 문자열을 붙이는 연산자를 ..으로 표기
-- 실수이면 실수를 문자열로 변환.
--
-----------------------------------------------------------------------------
--
-- 3.5 길이 연산자
-- 
-- 길이 연산자는 문자열과 테이블에 쓰임.
-- 문자열의 경우 몇 바이트인지 반환.
-- 테이블의 경우 테이블로 표현한 순열의 길이를 반환
--
-- a[#a] = nil 		-- 순열 a의 마지막 값을 제거
-- a[#a+1] = v		-- 리스트의 끝에 v를 추가
--
-- 순열은 연속된 숫자 키 집합(1...n)으로 구성된 테이블을 뜻함.
--
-----------------------------------------------------------------------------
--
-- 3.6 연산 우선순위
-- 
-- 다른 언어들과 비슷함. 궁금하면 검색...
-- 확실하지 않으면 항상 괄호를 명시적으로 쓰자.
--
-----------------------------------------------------------------------------
--
-- 3.7 테이블 생성자
-- 
-- 생성자는 테이블을 생성하고 초기화하는 표현식
-- 가장 간단한 생성자는 {}로 표현하는 빈 생성자
--
days = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"}
-- 위 문장은 days[1] = "Sunday", days[2] = "Monday", ..와 같다.
-- 인덱스는 항상 1번부터 시작함
--
a = {x=10, y=20}
-- 위처럼 레코드 형식으로 초기화도 지원.
-- a={} a.x=10 a.y=20 과 같다
--
-- 레코드 스타일과 리스트 스타일 초기화를 섞어서 사용도 가능
--
-----------------------------------------------------------------------------

-- 연습문제 3.1
-- 다음 프로그램의 출력 결과는?
for i=-10, 10 do
	print(i, i%3)
end
-- 예상 정답 : -10 -1 / -9 0 / ... 10 1
-- 실제 정답 : -10 2 / -9 0 / ... 10 1
-- -1은 나머지가 2, -2는 나머지가 1 이런식으로 나머지는 무조건 0~2로 숫자가 줄어들때마다 2 1 0 이 반복된다


-- 연습문제 3.2
-- 표현식 2^3^4의 결과는? 그리고 2^-3^4의 결과는
print(2^3^4)
print(2^-3^4)
-- 예상 정답 : 4096(앞에서부터 계산하여 8의 4승)		1/4096(1/8의 4승)
-- 실제 정답 : 3^4부터 계산되어 2의 81승				2의 -81승


-- 연습문제 3.7
-- 다음 코드를 실행하면 무엇이 출력될까?
sunday = "monday"
monday = "sunday"
t = {sunday = "monday", [sunday] = monday}
print(t.sunday, t[sunday], t[t.sunday])
-- 예상 정답 : monday  sunday  sunday
-- 실제 정답 : monday  sunday  sunday
-- 1번째는 t의 키가 sunday니 "monday"고, 2번째는 키가 [sunday]니 monday = "sunday", 
-- 3번째는 t["monday"] = t[sunday] = monday = "sunday"