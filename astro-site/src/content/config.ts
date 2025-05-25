import { defineCollection, z } from 'astro:content';

const brodersonsCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    category: z.string(),
    year: z.number().optional(),
    winner: z.boolean().optional(),
    agency: z.string().optional(),
    description: z.string().optional(),
    images: z.array(z.object({
      src: z.string(),
      alt: z.string(),
      caption: z.string().optional(),
    })).optional(),
    // draft: z.boolean().optional(), 
    // pubDate: z.date().optional(), 
  }),
});

const eventsCollection = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    date: z.string().transform((str) => new Date(str + 'T00:00:00Z')), // Treat date as UTC
    start_time: z.string().optional(),
    end_time: z.string().optional(),
    location: z.string().optional(),
    address: z.string().optional(),
    image: z.string().optional(),
    price: z.union([z.string(), z.number()]).optional(),
    ticket_link: z.string().url().optional(),
    button_label: z.string().optional(), // Added based on EventCard.astro usage
    detail_url: z.string().url().optional(), // Added based on EventCard.astro usage
    // draft: z.boolean().optional(),
  }),
});

export const collections = {
  'brodersons': brodersonsCollection,
  'events': eventsCollection,
};
