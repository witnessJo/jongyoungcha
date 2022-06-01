

PGDATA=$(HOME)/.postgres/data

# Run fbs db as a docker process
# Need configuration of follow files
# $(HOME)/.postgres/data/pg_hba.conf
# $(HOME)/.postgres/data/postgresql.conf
db:
	docker pull postgres
	docker kill postgres || true
	docker rm postgres || true
	if [ ! -d $(PGDATA) ]; then mkdir -p $(PGDATA); fi
	docker run -p 5432:5432 \
--name postgres \
-e POSTGRES_DB=fbs \
-e POSTGRES_USER=postgres \
-e POSTGRES_PASSWORD=sentbe1234. \
-e PGDATA=/var/lib/postgresql/data/pgdata \
-v $(PGDATA):/var/lib/postgresql/data/pgdata \
-d postgres
	sleep 5
	docker exec postgres psql -U postgres -d postgres -c "CREATE DATABASE fbs OWNER postgres;"

# Drop fbs db
drop-db:
	docker exec postgres psql -U postgres -d postgres -c "SELECT * FROM pg_stat_activity WHERE pg_stat_activity.datname='fbs'";
	docker exec postgres psql -U postgres -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'fbs'";
	docker exec postgres psql -U postgres -d postgres -c "DROP DATABASE fbs;"

.phony : db drop-db
