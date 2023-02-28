<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20230227195453 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP TABLE IF EXISTS lookup_country');
        $this->addSql('CREATE TABLE lookup_country (id INT AUTO_INCREMENT NOT NULL, label VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('INSERT INTO lookup_country (id, label) values (1, "Austria"), (2, "Germany")');
        $this->addSql('ALTER TABLE customer ADD country_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE customer ADD CONSTRAINT FK_81398E09F92F3E70 FOREIGN KEY (country_id) REFERENCES lookup_country (id)');
        $this->addSql('CREATE INDEX IDX_81398E09F92F3E70 ON customer (country_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE customer DROP FOREIGN KEY FK_81398E09F92F3E70');
        $this->addSql('DROP TABLE lookup_country');
        $this->addSql('DROP INDEX IDX_81398E09F92F3E70 ON customer');
        $this->addSql('ALTER TABLE customer DROP country_id');
    }
}
